crypto        = require("crypto")
passport      = require("passport")

mailTransporter = require '../lib/mailer'

###
GET /login
Login page.
###
exports.getLogin = (req, res) ->
  return res.redirect("/")  if req.user
  res.render "account/login",
    title: "Login"

###
POST /login
Sign in using email and password.
@param email
@param password
###
exports.postLogin = (req, res, next) ->
  req.assert("email", "Email is not valid").isEmail()
  req.assert("password", "Password cannot be blank").notEmpty()
  if errors = req.validationErrors()
    return res.render 'account/login', errors: errors

  passport.authenticate("local", (err, user, info) ->
    return next(err)  if err
    unless user
      return res.render 'account/login', msg: info.message
    req.logIn user, (err) ->
      return next(err)  if err

      res.redirect req.session.returnTo or "/"
  ) req, res, next

###
GET /logout
Log out.
###
exports.logout = (req, res) ->
  req.logout()
  res.redirect "/"

###
GET /signup
Signup page.
###
exports.getSignup = (req, res) ->
  return res.redirect("/")  if req.user
  res.render "account/signup",
    title: "Create Account"

###
POST /signup
Create a new local account.
@param email
@param password
###
exports.postSignup = (req, res, next) ->
  req.assert("email", "Email is not valid").isEmail()
  req.assert("password", "Password must be at least 4 characters long").len 4
  req.assert("confirmPassword", "Passwords do not match").equals req.body.password
  if errors = req.validationErrors()
    return res.render "account/signup", errors: errors

  user = new User email: req.body.email, password: req.body.password
  user.save (err) ->
    if err
      if err.code is 11000
        return res.render "account/signup", msg: "User with that email already exists."
    req.logIn user, (err) ->
      return next(err)  if err
      res.redirect "/"

exports.removePicture = (req, res) ->
  req.user.profile.picture = ""
  req.user.save (err) ->
    render_data = title: "Account Management"
    render_data.msg = "Unable to remove picture." if err
    res.render 'account/profile', render_data      

###
GET /account
Profile page.
###
exports.getAccount = (req, res) ->
  res.render "account/profile",
    title: "Account Management"

###
POST /account/profile
Update profile information.
###
exports.postUpdateProfile = (req, res, next) ->
  User.findById req.user.id, (err, user) ->
    return next(err)  if err
    user.email = req.body.email or ""
    user.profile.name = req.body.name or ""
    user.profile.gender = req.body.gender or ""
    user.profile.location = req.body.location or ""
    user.profile.website = req.body.website or ""
    user.save (err) ->
      return next(err)  if err
      res.redirect "/account"

###
POST /account/password
Update current password.
@param password
###
exports.postUpdatePassword = (req, res, next) ->
  req.assert("password", "Password must be at least 4 characters long").len 4
  req.assert("confirmPassword", "Passwords do not match").equals req.body.password
  errors = req.validationErrors()
  if errors
    # req.flash "errors", errors
    return res.redirect("/account")
  User.findById req.user.id, (err, user) ->
    return next(err)  if err
    user.password = req.body.password
    user.save (err) ->
      return next(err)  if err
      # req.flash "success",
      #   msg: "Password has been changed."

      res.redirect "/account"

###
POST /account/delete
Delete user account.
@param id - User ObjectId
###
# exports.postDeleteAccount = (req, res, next) ->
#   User.remove
#     _id: req.user.id
#   , (err) ->
#     return next(err)  if err
#     req.logout()
#     res.redirect "/"

###
GET /account/unlink/:provider
Unlink OAuth2 provider from the current user.
@param provider
@param id - User ObjectId
###
exports.getOauthUnlink = (req, res, next) ->
  provider = req.params.provider
  User.findById req.user.id, (err, user) ->
    return next(err)  if err
    user[provider] = `undefined`
    user.tokens = _.reject(user.tokens, (token) ->
      token.kind is provider
    )
    user.save (err) ->
      return next(err)  if err
      # req.flash "info",
      #   msg: provider + " account has been unlinked."

      res.redirect "/account"

###
GET /reset/:token
Reset Password page.
###
exports.getReset = (req, res) ->
  return res.redirect("/")  if req.isAuthenticated()
  User.findOne(resetPasswordToken: req.params.token).where("resetPasswordExpires").gt(Date.now()).exec (err, user) ->
    unless user
      # req.flash "errors",
      #   msg: "Password reset token is invalid or has expired."

      return res.redirect("/forgot")
    res.render "account/reset",
      title: "Password Reset"

###
POST /reset/:token
Process the reset password request.
###
exports.postReset = (req, res, next) ->
  req.assert("password", "Password must be at least 4 characters long.").len 4
  req.assert("confirm", "Passwords must match.").equals req.body.password
  errors = req.validationErrors()
  if errors
    # req.flash "errors", errors
    return res.redirect("back")

  User.findOne resetPasswordToken: req.params.token
    .where 'resetPasswordExpires'
    .gt Date.now()
    .then (user) ->
      unless user
        # req.flash "errors", msg: "Password reset token is invalid or has expired."
        return res.redirect("back")
      user.password = req.body.password
      user.resetPasswordToken = `undefined`
      user.resetPasswordExpires = `undefined`
      user.update(password: req.body.password, resetPasswordToken: `undefined`, resetPasswordExpires: `undefined`)
      .then ->
        mailOptions =
          to: user.email
          from: "hackathon@starter.com"
          subject: "Your Hackathon Starter password has been changed"
          text: "Hello,\n\n" + "This is a confirmation that the password for your account " + user.email + " has just been changed.\n"

        transporter.sendMail mailOptions, (err) ->
          # req.flash "success", msg: "Success! Your password has been changed."
          res.redirect '/'
  .catch next

exports.getForgot = (req, res) ->
  return res.redirect("/")  if req.isAuthenticated()
  res.render "account/forgot", title: "Forgot Password"

exports.postForgot = (req, res, next) ->
  req.assert("email", "Please enter a valid email address.").isEmail()
  errors = req.validationErrors()
  if errors
    # req.flash "errors", errors
    return res.redirect("/forgot")

  new Promise (res, rej) ->
    crypto.randomBytes 16, (err, buf) ->
      return rej err if err
      res buf.toString("hex")
  .then (token) ->
    User.findOne email: req.body.email.toLowerCase()
    .then (user) ->
      unless user
        # req.flash "errors", msg: "No account with that email address exists."
        return res.redirect("/forgot")
      user.resetPasswordToken = token
      user.resetPasswordExpires = Date.now() + (1000*60*60) # 1 hour
      user.update resetPasswordToken: token, resetPasswordExpires: Date.now() + (1000*60*60)
      .then ->
        mailOptions =
          to: user.email
          from: "hackathon@starter.com"
          subject: "Reset your password on Hackathon Starter"
          text: "You are receiving this email because you (or someone else) have requested the reset of the password for your account.\n\n" + "Please click on the following link, or paste this into your browser to complete the process:\n\n" + "http://" + req.headers.host + "/reset/" + token + "\n\n" + "If you did not request this, please ignore this email and your password will remain unchanged.\n"

        mailTransporter.sendMail mailOptions, (err) ->
          # req.flash "info", msg: "An e-mail has been sent to " + user.email + " with further instructions."
          res.redirect '/forgot'
  .catch next



