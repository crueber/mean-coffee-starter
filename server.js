
var app = require('./app');

app.listen(app.get('port'), function() { events.emit('ready'); });

module.exports = app;
