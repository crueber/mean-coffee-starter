require('coffee-script/register') // <-- Register the coffeescript interpreter for the whole project.

/**
 * Module dependencies.
 */
var secrets          = require('./config/secrets');
var logger           = require('morgan');
var express          = require('express');
var session          = require('express-session');
var mongoose         = require('mongoose');
var MongoStore       = require('connect-mongo')({ session: session });
var passport         = require('passport');
var passportConf     = require('./config/passport');
var app              = express();
var globals          = require('./config/globals')(app);

mongoose.connect(app.get('mongo_db'));
mongoose.connection.on('error', function() {
  console.error('✗ MongoDB Connection Error.');
});

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

app.listen(app.get('port'), function() {
  console.log("✔ Express server listening on port %d in %s mode", app.get('port'), app.get('env'));
});

module.exports = app;
