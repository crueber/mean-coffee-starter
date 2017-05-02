
startTime = new Date()

global.logger = require('./config/logger')()
global.dir_loader = require('./dir_loader')
global.vent = new (require('events'))()
global.events = require('./events')()
global.app = require('express')()

dir_loader './config', args: [app], prefix: 'config'
require('./config/databases')(app)
dir_loader './lib', args: [app], prefix: 'lib'

module.exports = base = (start) ->
  vent.on events.STARTUP_ROUTES_COMPLETE, -> logger.info "Started in #{((new Date())-startTime)/1000}s."
  vent.on events.STARTUP_DATABASE_COMPLETE, -> vent.emit events.STARTUP_MIDDLEWARE, app
  vent.on events.STARTUP_MIDDLEWARE_COMPLETE, -> vent.emit events.STARTUP_ROUTES, app
  vent.on events.STARTUP_ROUTES_COMPLETE, -> vent.emit events.STARTUP_COMPLETE, app

  vent.emit events.STARTUP_PREPARE, app

  if start
    vent.on events.STARTUP_COMPLETE, (app) ->
    	app.listen app.get('port'), -> 
        vent.emit events.SERVER_LISTENING

base(true) unless module.parent
