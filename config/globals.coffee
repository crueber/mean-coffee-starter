path    = require "path"
_       = require 'lodash'
async   = require 'async'
logger  = require('./logger')()
Emitter = require('events').EventEmitter

###
# Application Globals Setup
###
module.exports = (app) ->
  global._                   = _
  global.app                 = app
  global.async               = async
  global.logger              = logger
  global.events              = new Emitter()
  global.constant            = {}
  global.constant.one_ms     = 1
  global.constant.one_second = constant.one_ms * 1000
  global.constant.one_minute = constant.one_second * 60
  global.constant.one_hour   = constant.one_minute * 60
  global.constant.one_day    = constant.one_hour * 24
  global.constant.one_week   = constant.one_hour * 7
  global.constant.one_month  = constant.one_day * 30   # approx
  global.constant.one_year   = constant.one_week * 52  # approx

  application_globals =
    'dev':           app.get('env') isnt 'production'
    'port':          process.env.PORT or 3000
    'mongo_db':      process.env.MONGODB or "mongodb://localhost:27017/meanstart"
  # 'redis_host':    process.env.REDISHOST or '127.0.0.1'
  # 'redis_port':    process.env.REDISPORT or 6379
  # 'redis_auth':    process.env.REDISAUTH or false
  # 'redis_opts':    {}
  # 'postgres_db':   process.env['POSTGRES_DB'] || 'pg://user:pass@localhost/skeleton'
    'views':         path.join(__dirname, "/../views")
    'view engine':   'jade'
    'title':         'MEAN Coffee Baseline'
    'sessionSecret': process.env.SESSION_SECRET or 'meancoffee'
    'mail_host':     process.env.MAIL_HOST or '127.0.0.1'
    'mail_port':     process.env.MAIL_PORT or 1025
    'mail_username': process.env.MAIL_USERNAME or 'user'
    'mail_password': process.env.MAIL_PASSWORD or 'pass'

  app.set key, value for key, value of application_globals
  app.locals.title = application_globals['title']
  app.locals.dev   = application_globals['dev']
