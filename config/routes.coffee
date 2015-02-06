controllers  = require '../controllers'
passportConf = require './auth'
passport     = require 'passport'
express      = require 'express'
api_router   = require '../apis'

oauth_router = (app) ->
  router = express.Router()
  router.get "/google", passport.authenticate("google", scope: "profile email")
  router.get "/google/callback", passport.authenticate("google", failureRedirect: "/login"), (req, res) ->
    res.redirect req.session.returnTo or "/"
  router.get "/linkedin", passport.authenticate("linkedin", state: "SOME STATE" )
  router.get "/linkedin/callback", passport.authenticate("linkedin", failureRedirect: "/login"), (req, res) ->
    res.redirect req.session.returnTo or "/"
  router

auth_router = (app) ->
  router = express.Router()
  router.get "/login", controllers.user.getLogin
  router.post "/login", controllers.user.postLogin
  router.get "/logout", controllers.user.logout
  router.get "/forgot", controllers.user.getForgot
  router.post "/forgot", controllers.user.postForgot
  router.get "/reset/:token", controllers.user.getReset
  router.post "/reset/:token", controllers.user.postReset
  router.get "/signup", controllers.user.getSignup
  router.post "/signup", controllers.user.postSignup
  router.get "/account", passportConf.isAuthenticated, controllers.user.getAccount
  router.post "/account/profile", passportConf.isAuthenticated, controllers.user.postUpdateProfile
  router.get "/account/removePicture", passportConf.isAuthenticated, controllers.user.removePicture
  router.post "/account/password", passportConf.isAuthenticated, controllers.user.postUpdatePassword
  router.get "/account/unlink/:provider", passportConf.isAuthenticated, controllers.user.getOauthUnlink
  # router.post('/account/delete', passportConf.isAuthenticated, controllers.user.postDeleteAccount);
  router

page_router = (app) ->
  router = express.Router()
  router.get "/", passportConf.isAuthenticated, controllers.home.index
  router

module.exports = (app) ->
  app.use '/api', [ api_router(app) ]
  app.use '/', [ page_router(app), auth_router(app) ]
  app.use '/auth', [ oauth_router(app) ]
