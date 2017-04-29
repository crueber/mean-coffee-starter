
redis = require 'redis'

module.exports = (app) ->
  new Promise (res, rej) ->
    rej new Error "Unable to find redis connection string." unless app.get 'redis_host'

    host = app.get 'redis_host'
    port = app.get 'redis_port'
    opts = app.get 'redis_opts'
    auth = app.get 'redis_auth'

    redis_client = redis.createClient port, host, opts or {}
    redis_client.auth auth if auth
    redis_client.select app.get 'redisdb' if app.get 'redisdb'

    redis_client.on 'connect', -> 
      if app.get 'redisdb'
        redis_client.send_anyways = true
        redis_client.select app.get 'redisdb'
        redis_client.send_anyways = false
      app.set 'redis_client', redis_client
      logger.info 'Connection established to redis.'

      events.emit 'redis_connected'
      res()

    redis_client.on 'ready', -> logger.info 'Redis is ready.'
    redis_client.on 'end',   -> logger.info 'Connection to redis has been closed.'

    events.on 'shutdown', ->
      redis_client.quit()
      logger.info 'Redis connection gracefully disconnected.'
      events.emit 'redis_shutdown'
