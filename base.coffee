
global.events = Emitter = require('events').EventEmitter()
global.app = require('express')()

require('./config/globals')(app)
require('./config/databases')(app)
require('./config/express')(app)
require('./config/routes')(app)
require('./config/caboose')(app)
require('./config/supervisor')(app)
require('./lib/cron')(app)

module.exports = base = (start) ->
  events.emit 'startup'
  events.on 'databases-started', -> events.emit 'startup-middleware'
  events.on 'middleware-started', -> events.emit 'startup-routes'
  events.on 'routes-started', -> events.emit 'startup-complete'

  if start
    events.on 'startup-complete', ->
    	app.listen app.get('port'), -> 
        events.emit 'server-listening'

base(true) unless module.parent
