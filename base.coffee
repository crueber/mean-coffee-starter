
app = require('express')()

require('./config/globals')(app)
require('./config/databases')(app)
require('./config/express')(app)
require('./config/routes')(app)
require('./config/caboose')(app)
require('./config/supervisor')
require('./lib/cron')

unless module.parent
	app.listen app.get 'port', -> events.emit 'ready'

module.exports = app
