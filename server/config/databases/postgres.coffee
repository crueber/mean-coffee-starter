
pg  = require 'pg'

module.exports = (app) ->
  new Promise (res, rej) ->
    rej new Error "Postgres connection string not found." unless app.get 'postgres_db'

    postgres_config = 

    pg.connect app.get('postgres_db'), (err, client, done) ->
      app.set 'postgres_client', client

      vent.emit events.POSTGRES_CONNECTED, client
      vent.on events.APP_SHUTDOWN, ->
        done()
        logger.info 'Postgres connection disconnected gracefully.'
        vent.emit events.POSTGRES_DISCONNECTED

      res()
