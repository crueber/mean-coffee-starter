
module.exports = base = (start) ->
  app = require('express')()

  require('./config/globals')(app)
  require('./config/databases')(app)
  require('./config/express')(app)
  require('./config/routes')(app)
  require('./config/caboose')(app)
  require('./config/supervisor')
  require('./lib/cron')

  if start
  	app.listen app.get('port'), -> events.emit 'ready'

base(true) unless module.parent
