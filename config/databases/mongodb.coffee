
module.exports = (app) ->
  if app.get 'mongo_db'
    mongoose = require 'mongoose'

    mongoose.connect app.get 'mongo_db'
    mongoose.set 'debug', app.get('env') is 'development'
    mongoose.connection.on 'error',         -> logger.error 'MongoDB Connection Error'
    mongoose.connection.on 'disconnecting', -> logger.info 'MongoDB is disconnecting...'
    mongoose.connection.on 'disconnected',  -> logger.info 'MongoDB connection has successfully closed.'

    mongoose.connection.on 'connected',     -> 
      logger.info 'MongoDB Connection Established'
      require '../../models'

    events.on 'shutdown', ->
      mongoose.disconnect()
      logger.info 'Mongo disconnected gracefully.'
