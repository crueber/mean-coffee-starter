var fs = require('fs');
var http = require('http');
var https = require('https');

var app = require('./app');

var https_options = {
  key: fs.readFileSync('../../shared/config/ssl.key'),
  cert: fs.readFileSync('../../shared/config/ssl.crt')
}

http.createServer(app).listen(80);
https.createServer(https_options, app).listen(443);
events.emit('ready');

module.exports = app;
