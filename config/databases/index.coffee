
module.exports = (app) ->

  require('./mongodb')(app)
  require('./redis')(app)
  require('./postgres')(app)
