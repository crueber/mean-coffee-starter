bodyParser       = require("body-parser")
cookieParser     = require("cookie-parser")
compress         = require("compression")
connectAssets    = require("connect-assets")
express          = require("express")
expressValidator = require("express-validator")
favicon          = require("serve-favicon")
flash            = require("express-flash")
methodOverride   = require("method-override")
passport         = require("passport")
path             = require("path")
session          = require("express-session")
MongoStore       = require("connect-mongo")(session)
# RedisStore       = require('connect-redis')(session);
userAgentCheck   = require("./middleware/user_agent_check")
requestLogger    = require("./middleware/request_logger")
healthCheck      = require("./middleware/health_check")

module.exports = (app) ->
  buildDir = if app.get('env') isnt 'production' then false else ".tmp"

  app.use healthCheck
  app.use requestLogger(logger)
  app.use compress()
  app.use connectAssets(
    paths: [ "public/css", "public/js" ]
    helperContext: app.locals
    buildDir: buildDir
  )
  app.use favicon(__dirname + '/../public/favicon.ico')
  if app.get('env') == 'production'
    app.use express.static(path.join(__dirname, "/../public"), maxAge: constant.one_week)
  else
    app.use express.static(path.join(__dirname, "/../public"), maxAge: constant.one_second)
  app.use userAgentCheck(logger)
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)
  app.use expressValidator()
  app.use methodOverride('X-HTTP-Method-Override')
  app.use cookieParser()
  app.use session(
    secret: app.get('sessionSecret')
    store: new MongoStore(url: app.get('mongo_db'), auto_reconnect: true)
    # store: new RedisStore(client: app.get('redis_client'))
    saveUninitialized: true
    resave: true
  )
  app.use passport.initialize()
  app.use passport.session()
  app.use (req, res, next) ->
    res.locals.user = req.user
    next()
  app.use flash()
  app.use (req, res, next) ->
    return next()  if req.method isnt "GET"
    path = req.path.split("/")[1]
    return next()  if /(auth|login|logout|signup)$/i.test(path)
    req.session.returnTo = req.path
    next()
