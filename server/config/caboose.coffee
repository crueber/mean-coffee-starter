
controllers  = require '../controllers'

module.exports = (app) ->
  vent.on events.STARTUP_COMPLETE, ->
    app.use (req, res) -> res.status(404).end()
