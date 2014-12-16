path = require "path"

global._ = require 'lodash'
global.logger = require('./logger')()

global.constant = {}
global.constant.one_ms     = 1
global.constant.one_second = constant.one_ms * 1000
global.constant.one_minute = constant.one_second * 60
global.constant.one_hour   = constant.one_minute * 60
global.constant.one_day    = constant.one_hour * 24
global.constant.one_week   = constant.one_hour * 7

###
# Application Globals Setup
###
module.exports = (app) ->
  application_globals =
    'dev':           app.get('env') isnt 'production'
    'port':          process.env.PORT or 3000
    'mongo_db':      process.env.MONGODB or "mongodb://localhost:27017/meanstart"
  # 'redis_host':    process.env.REDISHOST or '127.0.0.1'
  # 'redis_port':    process.env.REDISPORT or 6379
  # 'redis_auth':    process.env.REDISAUTH or false
  # 'redis_opts':    {}
    'views':         path.join(__dirname, "/../views")
    'view engine':   'jade'
    'title':         'MEAN Coffee Baseline'
    'mail_host':     process.env.MAIL_HOST || '127.0.0.1'    # These are mailcatacher defaults.
    'mail_port':     process.env.MAIL_PORT || 1025
    'mail_username': process.env.MAIL_USERNAME || 'user'
    'mail_password': process.env.MAIL_PASSWORD || 'pass'

  app.set key, value for key, value of application_globals
  app.locals.title = app.get('title')
  global.app = app
