
mongoose = require 'mongoose'

module.exports = (app) ->
  new Promise (res, rej) ->
    rej new Error "Mongo connection string not found." unless app.get 'mongo_db'

    mongoose.set 'debug', app.get('env') is 'development'
    mongoose.connect app.get 'mongo_db'
    mongoose.connection.on 'error',         -> logger.error 'MongoDB Connection Error'
    mongoose.connection.on 'disconnecting', -> logger.info 'MongoDB is disconnecting...'
    mongoose.connection.on 'disconnected',  -> logger.info 'MongoDB connection has successfully closed.'

    mongoose.connection.on 'connected',     -> 
      logger.info 'MongoDB Connection Established'
      require '../../models'
      vent.emit events.MONGO_CONNECTED
      res()

    vent.on events.APP_SHUTDOWN, ->
      mongoose.disconnect()
      logger.info 'Mongo disconnected gracefully.'
      vent.emit events.MONGO_DISCONNECTED
