mongoose = require "mongoose"
bcrypt   = require "bcrypt-nodejs"
crypto   = require "crypto"
plugin   = require './plugins'
Promise  = require 'bluebird'
jwt      = require 'jsonwebtoken'
verify_jwt = Promise.promisify jwt.verify
sign_jwt = Promise.promisify jwt.sign

userSchema = new mongoose.Schema(
  email: { type: String, unique: true, lowercase: true}
  password: String
  profile:
    name: { type: String, default: "" }
    # gender: { type: String, default: "" }
    # location: { type: String,  default: "" }
    # website: { type: String, default: "" }
    picture: { type: String, default: "" }
  resetPasswordToken: String
  resetPasswordExpires: Date

  google: String
  linkedin: String
  tokens: Array

  activated: { type: Boolean, default: true }
  activation_token: String
)

userSchema.plugin(plugin.createdOn, { index: true });
userSchema.plugin(plugin.updatedOn, { index: true });

jwt_secret = 'this is a secret'
userSchema.static
  verify_jwt: (token) -> 
    verify_jwt token, jwt_secret

userSchema.method
  generate_jwt: ->
    payload = JSON.stringify 
      id: @_id
    sign_jwt payload, jwt_secret

  comparePassword: (candidatePassword, cb) ->
    bcrypt.compare candidatePassword, @password, (err, isMatch) ->
      return cb(err)  if err
      cb null, isMatch

  gravatar: (size, defaults) ->
    size = 200  unless size
    defaults = "retro"  unless defaults
    return "https://gravatar.com/avatar/?s=" + size + "&d=" + defaults  unless @email
    md5 = crypto.createHash("md5").update(@email)
    "https://gravatar.com/avatar/" + md5.digest("hex").toString() + "?s=" + size + "&d=" + defaults

userSchema.pre "save", (next) ->
  user = this
  return next()  unless user.isModified("password")
  bcrypt.genSalt 5, (err, salt) ->
    return next(err)  if err
    bcrypt.hash user.password, salt, null, (err, hash) ->
      return next(err)  if err
      user.password = hash
      next()

module.exports = mongoose.model("User", userSchema)