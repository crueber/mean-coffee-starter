crypto        = require("crypto")
passport      = require("passport")

mailTransporter = require '../lib/mailer'


# exports.removePicture = (req, res) ->
#   req.user.profile.picture = ""
#   req.user.save (err) ->
#     render_data = title: "Account Management"
#     render_data.msg = "Unable to remove picture." if err
#     res.render 'account/profile', render_data      

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



