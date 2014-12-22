nodemailer    = require 'nodemailer'
smtpTransport = require 'nodemailer-smtp-transport'

transport_options = 
  port: app.get('mail_port')
  host: app.get('mail_host')
  auth:
    user: app.get('mail_username')
    pass: app.get('mail_password')

mailTransporter = nodemailer.createTransport(smtpTransport(transport_options))

module.exports = mailTransporter

