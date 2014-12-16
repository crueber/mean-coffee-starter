
# redis    = require 'redis'
mongoose = require 'mongoose'

module.exports = (app) ->
  # host = app.get 'redis_host'
  # port = app.get 'redis_port'
  # opts = app.get 'redis_opts'
  # auth = app.get 'redis_auth'
  mongo_db = app.get 'mongo_db'
  env = app.get 'env'

  # redis_client = redis.createClient port, host, opts
  # redis_client.auth auth if auth
  # app.set 'redis_client', redis_client

  mongoose.connect mongo_db
  mongoose.connection.on 'error', ->
    console.error '✗ MongoDB Connection Error.'
  mongoose.set 'debug', env is 'development'

  true

