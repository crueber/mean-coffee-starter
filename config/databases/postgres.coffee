
pg  = require 'pg'

module.exports = (app) ->
  new Promise (res, rej) ->
    rej new Error "Postgres connection string not found." unless app.get 'postgres_db'

    postgres_config = 

    pg.connect app.get('postgres_db'), (err, client, done) ->
      app.set 'postgres_client', client

      events.emit 'postgres_connected', client
      events.on 'shutdown', ->
        done()
        logger.info 'Postgres connection disconnected gracefully.'
        events.emit 'postgres_shutdown'

      res()
