
controllers  = require '../controllers'

module.exports = (app) ->
  vent.on events.STARTUP_COMPLETE, ->
    app.use controllers.home.index
