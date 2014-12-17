
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
  # pg_done = null
  # pg.connect postgres_config, (err, client, done) ->
  #   app.set 'postgres_client', client
  #   pg_done = done

  events.on 'shutdown', ->
    redis_client.quit()   unless typeof redis_client is 'undefined' or redis_client is null
    pg_done()             unless typeof pg_done is 'undefined' or pg_done is null
    mongoose.disconnect() unless typeof mongoose is 'undefined' or mongoose is null

    logger.info 'All database connections closed.'

  true

