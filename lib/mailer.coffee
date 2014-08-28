secrets       = require '../config/secrets'
nodemailer    = require 'nodemailer'
smtpTransport = require 'nodemailer-smtp-transport'

transport_options = 
  service: "SendGrid"
  auth:
    user: secrets.sendgrid.user
    pass: secrets.sendgrid.password

mailTransporter = nodemailer.createTransport(smtpTransport(transport_options))

module.exports = mailTransporter

