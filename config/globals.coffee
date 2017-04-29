
path    = require "path"

set_globals = (app) ->
  global._                   = require 'lodash'
  global.moment              = require 'moment'
  global.logger              = require('./logger')()
  global.empty_fn            = -> null
  global.constant            = {}
  global.constant.one_ms     = 1
  global.constant.one_second = constant.one_ms * 1000
  global.constant.one_minute = constant.one_second * 60
  global.constant.one_hour   = constant.one_minute * 60
  global.constant.one_day    = constant.one_hour * 24
  global.constant.one_week   = constant.one_hour * 7
  global.constant.one_month  = constant.one_day * 30   # approx
  global.constant.one_year   = constant.one_week * 52  # approx
  global.constant.one_byte   = 1
  global.constant.one_kb     = 1024 * global.constant.one_byte
  global.constant.one_mb     = 1024 * global.constant.one_kb
  global.constant.one_gb     = 1024 * global.constant.one_mb

  application_globals =
    'dev':           app.get('env') isnt 'production'
    'views':         path.join(__dirname, "/../views")
    'view engine':   'pug'
    'title':         'MEAN Coffee Baseline'
    'port':          process.env.PORT
    'sessionSecret': process.env.SESSION_SECRET
    'mail_host':     process.env.MAIL_HOST
    'mail_port':     process.env.MAIL_PORT
    'mail_username': process.env.MAIL_USERNAME
    'mail_password': process.env.MAIL_PASSWORD
    'mongo_db':      process.env.MONGODB or 'mongodb://192.168.99.100:27017/mean-coffee-starter'
    'redis_host':    process.env.REDISHOST  or '192.168.99.100'
    'redis_port':    process.env.REDISPORT or 6379
    # 'redis_auth':    process.env.REDISAUTH
    # 'redis_opts':    {}
    # 'postgres_db':   process.env.POSTGRESDB

  app.set key, value for key, value of application_globals
  app.locals.title = application_globals['title']
  app.locals.dev   = application_globals['dev']


module.exports = (app) ->
  events.on 'startup', -> set_globals(app)