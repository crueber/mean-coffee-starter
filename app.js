require('coffee-script/register') // <-- Register the coffeescript interpreter for the whole project.

var app = require('express')();

require('./config/globals')(app);
require('./config/databases')(app);
require('./models');
require('./config/express')(app);
require('./config/routes')(app);
require('./config/caboose')(app);

if(!module.parent) {
  app.listen(app.get('port'), function() {
    logger.info("✔ Express server listening on port %d in %s mode", app.get('port'), app.get('env'));
  });
}

module.exports = app;
