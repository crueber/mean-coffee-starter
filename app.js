require('coffee-script/register') // <-- Register the coffeescript interpreter for the whole project.

/**
 * Module dependencies.
 */
var secrets          = require('./config/secrets');
var express          = require('express');
var mongoose         = require('mongoose');
// var redis            = require('redis');
var passport         = require('passport');
var passportConf     = require('./config/passport');
var app              = express();
var globals          = require('./config/globals')(app);

// var redis_client = redis.createClient(app.get('redis_port'), app.get('redis_host'), app.get('redis_opts'))
// if (app.get('redis_auth')) {
//   redis_client.auth(app.get('redis_auth'));
// }
// app.set('redis_client', redis_client);
mongoose.connect(app.get('mongo_db'));
mongoose.connection.on('error', function() {
  console.error('✗ MongoDB Connection Error.');
});
if (app.get('env') === 'development') mongoose.set('debug', true)


require('./models')
require('./config/express')(app);
require('./config/routes')(app);

// 404 error handler
app.use(function(req, res) {
  res.status(404);
  res.render('404');
});

// 500 error handler
app.use(require('errorhandler')());

if(!module.parent) {
  app.listen(app.get('port'), function() {
    logger.info("✔ Express server listening on port %d in %s mode", app.get('port'), app.get('env'));
  });
}

module.exports = app;
