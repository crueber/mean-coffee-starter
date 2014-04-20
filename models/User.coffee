mongoose = require "mongoose"
bcrypt   = require "bcrypt-nodejs"
crypto   = require "crypto"
plugin   = require './plugins'

userSchema = new mongoose.Schema(
  email: { type: String, unique: true, lowercase: true}
  password: String
  profile:
    name: { type: String, default: "" }
    # gender: { type: String, default: "" }
    # location: { type: String,  default: "" }
    website: { type: String, default: "" }
    picture: { type: String, default: "" }
  resetPasswordToken: String
  resetPasswordExpires: Date

  google: String
  linkedin: String
  tokens: Array
)

userSchema.plugin(plugin.createdOn, { index: true });
userSchema.plugin(plugin.updatedOn, { index: true });
userSchema.plugin(plugin.deletedOn, { index: true });


###
Hash the password for security.
"Pre" is a Mongoose middleware that executes before each user.save() call.
###
userSchema.pre "save", (next) ->
  user = this
  return next()  unless user.isModified("password")
  bcrypt.genSalt 5, (err, salt) ->
    return next(err)  if err
    bcrypt.hash user.password, salt, null, (err, hash) ->
      return next(err)  if err
      user.password = hash
      next()

###
Validate user's password.
Used by Passport-Local Strategy for password validation.
###
userSchema.methods.comparePassword = (candidatePassword, cb) ->
  bcrypt.compare candidatePassword, @password, (err, isMatch) ->
    return cb(err)  if err
    cb null, isMatch

###
Get URL to a user's gravatar.
Used in Navbar and Account Management page.
###
userSchema.methods.gravatar = (size, defaults) ->
  size = 200  unless size
  defaults = "retro"  unless defaults
  return "https://gravatar.com/avatar/?s=" + size + "&d=" + defaults  unless @email
  md5 = crypto.createHash("md5").update(@email)
  "https://gravatar.com/avatar/" + md5.digest("hex").toString() + "?s=" + size + "&d=" + defaults

module.exports = mongoose.model("User", userSchema)