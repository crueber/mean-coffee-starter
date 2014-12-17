
# redis    = require 'redis'
# mongoose = require 'mongoose'

module.exports = (app) ->
  # ***************************
  # *** Redis Configuration ***
  # ***************************

  # host = app.get 'redis_host'
  # port = app.get 'redis_port'
  # opts = app.get 'redis_opts'
  # auth = app.get 'redis_auth'
  # redis_client = redis.createClient port, host, opts
  # redis_client.auth auth if auth
  # app.set 'redis_client', redis_client

  # *****************************
  # *** MongoDB Configuration ***
  # *****************************

  # mongo_db = app.get 'mongo_db'
  # env = app.get 'env'
  # mongoose.connect mongo_db
  # mongoose.connection.on 'error', ->
  #   console.error '✗ MongoDB Connection Error.'
  # mongoose.set 'debug', env is 'development'

  # ******************************
  # *** Postgres Configuration ***
  # ******************************

  # postgres_config = app.get('postgres_db')  
  # pg.connect postgres_config, (err, client, done) ->
  #   client.query '', (err, result) ->
  #     do_something() if result.rows and result.rows[0]
  #     done()

  true

