nodemailer = require 'nodemailer'

Mail = nodemailer.createTransport 'smtp',
  host: app.get 'mail_host'
  port: app.get 'mail_port'
  name: 'Exeras'
  auth:
    user: app.get 'mail_username'
    pass: app.get 'mail_password'

module.exports = Mail