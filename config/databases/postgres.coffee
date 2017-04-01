module.exports = (app) ->

  if app.get 'postgres_db'
    pg  = require 'pg'
    postgres_config = app.get 'postgres_db'

    pg.connect postgres_config, (err, client, done) ->
      app.set 'postgres_client', client

      events.on 'shutdown', ->
        done()
        logger.info 'Postgres connection disconnected gracefully.'
