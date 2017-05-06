bodyParser       = require("body-parser")
compress         = require("compression")
express          = require("express")
expressValidator = require("express-validator")
methodOverride   = require("method-override")
passport         = require("passport")
path             = require("path")
session          = require("express-session")
middleware       = dir_loader __dirname+'/middleware', curried: false, prefix: 'middleware'

module.exports = (app) ->
  vent.on events.STARTUP_MIDDLEWARE, ->
    buildDir = if app.get('env') isnt 'production' then false else ".tmp"

    app.use middleware.health_check
    app.use middleware.request_logger(logger)
    app.use compress()
    app.use middleware.user_agent_check(logger)
    app.use bodyParser.json()
    app.use bodyParser.urlencoded(extended: true)
    app.use expressValidator()
    app.use methodOverride('X-HTTP-Method-Override')
    app.use passport.initialize()

    vent.emit events.STARTUP_MIDDLEWARE_COMPLETE
