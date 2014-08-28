express          = require("express")
cookieParser     = require("cookie-parser")
compress         = require("compression")
session          = require("express-session")
bodyParser       = require("body-parser")
favicon          = require("static-favicon")
logger           = require("morgan")
methodOverride   = require("method-override")
MongoStore       = require("connect-mongo")(session: session)
flash            = require("express-flash")
path             = require("path")
mongoose         = require("mongoose")
passport         = require("passport")
expressValidator = require("express-validator")
connectAssets    = require("connect-assets")
secrets          = require("./secrets")
passportConf     = require("./passport")

module.exports = (app) ->
  app.use connectAssets(
    paths: [ "public/css", "public/js" ]
    helperContext: app.locals
    buildDir: ".tmp"
  )
  app.use compress()
  app.use favicon()
  app.use logger("dev")
  if app.get('env') == 'production'
    app.use express.static(path.join(__dirname, "/../public"), maxAge: constant.one_week)
  else
    app.use express.static(path.join(__dirname, "/../public"), maxAge: constant.one_second)
  app.use bodyParser.json()
  app.use bodyParser.urlencoded(extended: true)
  app.use expressValidator()
  app.use methodOverride('X-HTTP-Method-Override')
  app.use cookieParser()
  app.use session(
    secret: secrets.sessionSecret
    store: new MongoStore(url: app.get('mongo_db'), auto_reconnect: true)
    saveUninitialized: true
    resave: true
  )
  app.use passport.initialize()
  app.use passport.session()
  app.use (req, res, next) ->
    res.locals.user = req.user
    res.locals.secrets = secrets
    next()
  app.use flash()
  app.use (req, res, next) ->
    return next()  if req.method isnt "GET"
    path = req.path.split("/")[1]
    return next()  if /(auth|login|logout|signup)$/i.test(path)
    req.session.returnTo = req.path
    next()
