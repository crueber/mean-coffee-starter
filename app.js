require('coffee-script/register'); // <-- Register the coffeescript interpreter for the whole project.

var app = require('express')();

require('./config/globals')(app);
require('./config/databases')(app);
require('./models');
require('./config/express')(app);
require('./config/routes')(app);
require('./config/caboose')(app);
require('./config/supervisor');

if(!module.parent) {
  app.listen(app.get('port'), function() { events.emit('ready'); });
}

require('./lib/cron');

module.exports = app;
