secrets       = require '../config/secrets'
nodemailer    = require 'nodemailer'
smtpTransport = require 'nodemailer-smtp-transport'

transport_options = 
  port: secrets.email.port
  host: secrets.email.host
  auth:
    user: secrets.email.user
    pass: secrets.email.password

mailTransporter = nodemailer.createTransport(smtpTransport(transport_options))

module.exports = mailTransporter

