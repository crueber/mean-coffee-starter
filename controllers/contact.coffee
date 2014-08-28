secrets       = require "../config/secrets"
mailer        = require '../lib/mailer'

###
GET /contact
Contact form page.
###
exports.getContact = (req, res) ->
  res.render "contact", title: "Contact"

###
POST /contact
Send a contact form via Nodemailer.
@param email
@param name
@param message
###
exports.postContact = (req, res) ->
  req.assert("name", "Name cannot be blank").notEmpty()
  req.assert("email", "Email is not valid").isEmail()
  req.assert("message", "Message cannot be blank").notEmpty()
  errors = req.validationErrors()
  if errors
    req.flash "errors", errors
    return res.redirect("/contact")

  mailer.sendMail 
    to: "your@email.com"
    from: req.body.email
    subject: "Contact Form | MEAN Coffee Starter"
    text: req.body.message
  , (err) ->
    if err
      req.flash "errors",
        msg: err.message
      return res.redirect("/contact")
    req.flash "success",
      msg: "Email has been sent successfully!"
    res.redirect "/contact"
