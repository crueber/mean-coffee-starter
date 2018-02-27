
const crypto = require("crypto");
const passport = require("passport");
const mailTransporter = require('../lib/mailer');

// # exports.removePicture = (req, res) ->
// #   req.user.profile.picture = ""
// #   req.user.save (err) ->
// #     render_data = title: "Account Management"
// #     render_data.msg = "Unable to remove picture." if err
// #     res.render 'account/profile', render_data      

exports.postReset = (req, res, next) => {
  req.assert("password", "Password must be at least 4 characters long.").len(4);
  req.assert("confirm", "Passwords must match.").equals(req.body.password);
  const errors = req.validationErrors();
  if (errors) { return res.redirect("back"); }
  return User.findOne({
    resetPasswordToken: req.params.token
  }).where('resetPasswordExpires').gt(Date.now()).then(function(user) {
    if (!user) { return res.redirect("back"); }
    user.password = req.body.password;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpires = undefined;
    return user.update({
      password: req.body.password,
      resetPasswordToken: undefined,
      resetPasswordExpires: undefined
    }).then(() => {
      const mailOptions = {
        to: user.email,
        from: "hackathon@starter.com",
        subject: "Your Hackathon Starter password has been changed",
        text: "Hello,\n\n" + "This is a confirmation that the password for your account " + user.email + " has just been changed.\n"
      };
      return transporter.sendMail(mailOptions, (err) => {
        return res.redirect('/');
      });
    });
  }).catch(next);
};

exports.postForgot = (req, res, next) => {
  req.assert("email", "Please enter a valid email address.").isEmail();
  const errors = req.validationErrors();
  if (errors) { return res.redirect("/forgot"); }
  return new Promise((res, rej) => {
    return crypto.randomBytes(16, (err, buf) => {
      if (err) { return rej(err); }
      return res(buf.toString("hex"));
    });
  }).then((token) => {
    return User.findOne({
      email: req.body.email.toLowerCase()
    }).then((user) => {
      if (!user) { return res.redirect("/forgot"); }
      user.resetPasswordToken = token;
      user.resetPasswordExpires = Date.now() + (1000 * 60 * 60);
      return user.update({
        resetPasswordToken: token,
        resetPasswordExpires: Date.now() + (1000 * 60 * 60)
      }).then(function() {
        const mailOptions = {
          to: user.email,
          from: "hackathon@starter.com",
          subject: "Reset your password on Hackathon Starter",
          text: "You are receiving this email because you (or someone else) have requested the reset of the password for your account.\n\n" + "Please click on the following link, or paste this into your browser to complete the process:\n\n" + "http://" + req.headers.host + "/reset/" + token + "\n\n" + "If you did not request this, please ignore this email and your password will remain unchanged.\n"
        };
        return mailTransporter.sendMail(mailOptions, (err) => { return res.redirect('/forgot'); });
      });
    });
  }).catch(next);
};
