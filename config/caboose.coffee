
controllers  = require '../controllers'

module.exports = (app) ->

  app.use controllers.home.index
