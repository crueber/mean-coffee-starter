
module.exports = (app) ->

  events.on 'startup', (app) ->
    databases = [
      require('./mongodb')(app)
      require('./redis')(app)
      # require('./postgres')(app)
    ]
    
    Promise.all(databases).then -> 
      events.emit 'databases-started'

