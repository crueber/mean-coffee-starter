passport         = require("passport")

require('./local')
require('./google')
require('./linkedin')

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done err, user

module.exports =
  # Login Required middleware.
  isAuthenticated: (req, res, next) ->
    return next()  if req.isAuthenticated()
    res.redirect "/login"

  # Authorization Required middleware.
  isAuthorized: (req, res, next) ->
    provider = req.path.split("/").slice(-1)[0]
    if _.find(req.user.tokens, kind: provider)
      next()
    else
      res.redirect "/auth/" + provider
