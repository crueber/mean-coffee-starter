const mongoose = require("mongoose");
const bcrypt = require("bcrypt-nodejs");
const crypto = require("crypto");
const plugin = require('./plugins');
const Promise = require('bluebird');
const jwt = require('jsonwebtoken');

const verify_jwt = Promise.promisify(jwt.verify);
const sign_jwt = Promise.promisify(jwt.sign);

const userSchema = new mongoose.Schema({
  email: { type: String, unique: true, lowercase: true },
  password: String,
  profile: {
    name: { type: String, default: "" },
    // gender: { type: String, default: "" },
    // location: { type: String, default: "" },
    // website: { type: String, default: "" },
    picture: { type: String, default: "" }
  },
  resetPasswordToken: String,
  resetPasswordExpires: Date,
  google: String,
  linkedin: String,
  tokens: Array,
  activated: { type: Boolean, default: true },
  activation_token: String
});

userSchema.plugin(plugin.createdOn, { index: true });
userSchema.plugin(plugin.updatedOn, { index: true });

const jwt_secret = 'this is a secret';
userSchema.static({
  verify_jwt: function(token) {
    return verify_jwt(token, jwt_secret);
  }
});

userSchema.method({
  generate_jwt: function() {
    const payload = JSON.stringify({ id: this._id });
    return sign_jwt(payload, jwt_secret);
  },
  comparePassword: function(candidatePassword, cb) {
    return bcrypt.compare(candidatePassword, this.password, function(err, isMatch) {
      if (err) { return cb(err); }
      return cb(null, isMatch);
    });
  },
  gravatar: function(size, defaults) {
    if (!size) { size = 200; }
    if (!defaults) { defaults = "retro"; }
    if (!this.email) { return "https://gravatar.com/avatar/?s=" + size + "&d=" + defaults; }
    const md5 = crypto.createHash("md5").update(this.email);
    return "https://gravatar.com/avatar/" + md5.digest("hex").toString() + "?s=" + size + "&d=" + defaults;
  }
});

userSchema.pre("save", function(next) {
  const user = this;
  if (!user.isModified("password")) { return next(); }
  return bcrypt.genSalt(5, (err, salt) => {
    if (err) { return next(err); }
    return bcrypt.hash(user.password, salt, null, function(err, hash) {
      if (err) { return next(err); }
      user.password = hash;
      return next();
    });
  });
});

module.exports = mongoose.model("User", userSchema);
