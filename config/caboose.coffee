server_error_handler = require('errorhandler')()

module.exports = (app) ->

  app.use (req, res) ->
    res.status 404
    res.render '404'

  app.use server_error_handler
