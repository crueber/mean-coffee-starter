
global.logger = require('./config/logger')()
global.dir_loader = require('./dir_loader')
global.vent = new (require('events'))()
global.events = require('./events')()
global.app = require('express')()

console.log JSON.stringify dir_loader './config', args: [app]
require('./config/databases')(app)
console.log JSON.stringify dir_loader './lib', args: [app]

# require('./config/globals')(app)

# require('./config/express')(app)
# require('./config/routes')(app)
# require('./config/caboose')(app)
# require('./config/supervisor')(app)
# require('./lib/cron')(app)

module.exports = base = (start) ->
  vent.emit events.STARTUP_PREPARE, app
  vent.on events.STARTUP_DATABASE_COMPLETE, -> vent.emit events.STARTUP_MIDDLEWARE, app
  vent.on events.STARTUP_MIDDLEWARE_COMPLETE, -> vent.emit events.STARTUP_ROUTES, app
  vent.on events.STARTUP_ROUTES_COMPLETE, -> vent.emit events.STARTUP_COMPLETE, app

  if start
    vent.on events.STARTUP_COMPLETE, (app) ->
    	app.listen app.get('port'), -> 
        vent.emit events.SERVER_LISTENING

base(true) unless module.parent
