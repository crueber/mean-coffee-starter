
controllers  = require '../controllers'

module.exports = (app) ->
  events.on 'startup-complete', ->
    app.use controllers.home.index
