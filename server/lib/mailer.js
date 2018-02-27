
const nodemailer = require('nodemailer');
const smtpTransport = require('nodemailer-smtp-transport');

module.exports = nodemailer.createTransport(smtpTransport({
  port: app.get('mail_port'),
  host: app.get('mail_host'),
  auth: {
    user: app.get('mail_username'),
    pass: app.get('mail_password')
  }
}));
