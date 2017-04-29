
module.exports = (app) ->

  vent.on events.STARTUP_PREPARE, (app) ->
    databases = [
      require('./mongodb')(app)
      require('./redis')(app)
      # require('./postgres')(app)
    ]
    
    Promise.all(databases).then -> 
      vent.emit events.STARTUP_DATABASE_COMPLETE

