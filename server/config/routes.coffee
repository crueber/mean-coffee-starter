controllers  = require '../controllers'
passportConf = require './auth'
passport     = require 'passport'
express      = require 'express'
api_router   = require '../apis'


auth_router = (app) ->
  router = express.Router()
  # router.get "/logout", controllers.user.logout

  router.get "/auth/google", passport.authenticate("google", scope: "profile email")
  router.get "/auth/google/callback", passport.authenticate("google", failureRedirect: "/login"), (req, res) ->
    res.redirect req.session.returnTo or "/"
  router.get "/auth/linkedin", passport.authenticate("linkedin", state: "SOME STATE" )
  router.get "/auth/linkedin/callback", passport.authenticate("linkedin", failureRedirect: "/login"), (req, res) ->
    res.redirect req.session.returnTo or "/"

  # router.post "/login", controllers.user.postLogin
  # router.post "/signup", controllers.user.postSignup
  router.post "/forgot", controllers.user.postForgot
  router.post "/reset/:token", controllers.user.postReset
  # router.post('/account/delete', passportConf.isAuthenticated, controllers.user.postDeleteAccount);

  # router.post "/account/profile", passportConf.isAuthenticated, controllers.user.postUpdateProfile
  # router.get "/account/removePicture", passportConf.isAuthenticated, controllers.user.removePicture
  # router.post "/account/password", passportConf.isAuthenticated, controllers.user.postUpdatePassword
  # router.get "/account/unlink/:provider", passportConf.isAuthenticated, controllers.user.getOauthUnlink

  router

page_router = (app) ->
  router = express.Router()
  router.get "/", passportConf.isAuthenticated, controllers.home.index
  router

module.exports = (app) ->
  vent.on events.STARTUP_ROUTES, ->
    app.use '/api', [ api_router(app) ]
    app.use '/', [ page_router(app), auth_router(app) ]
    vent.emit events.STARTUP_ROUTES_COMPLETE
