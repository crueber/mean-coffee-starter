controllers  = require '../controllers'
passportConf = require './passport'
passport     = require 'passport'

module.exports = (app) ->

  ###
  # Application routes.
  ###
  app.get "/", passportConf.isAuthenticated, controllers.home.index
  app.get "/login", controllers.user.getLogin
  app.post "/login", controllers.user.postLogin
  app.get "/logout", controllers.user.logout
  app.get "/forgot", controllers.user.getForgot
  app.post "/forgot", controllers.user.postForgot
  app.get "/reset/:token", controllers.user.getReset
  app.post "/reset/:token", controllers.user.postReset
  app.get "/signup", controllers.user.getSignup
  app.post "/signup", controllers.user.postSignup
  # app.get "/contact", controllers.contact.getContact
  # app.post "/contact", controllers.contact.postContact
  app.get "/account", passportConf.isAuthenticated, controllers.user.getAccount
  app.post "/account/profile", passportConf.isAuthenticated, controllers.user.postUpdateProfile
  app.post "/account/password", passportConf.isAuthenticated, controllers.user.postUpdatePassword
  app.get "/account/unlink/:provider", passportConf.isAuthenticated, controllers.user.getOauthUnlink
  app.get "/api/linkedin", passportConf.isAuthenticated, passportConf.isAuthorized, controllers.api.getLinkedin
  # app.post('/account/delete', passportConf.isAuthenticated, controllers.user.postDeleteAccount);
  # app.get('/api/scraping', controllers.api.getScraping);

  ###
  # OAuth routes for sign-in.
  ###
  app.get "/auth/google", passport.authenticate("google", scope: "profile email")
  app.get "/auth/google/callback", passport.authenticate("google", failureRedirect: "/login" ), (req, res) ->
    res.redirect req.session.returnTo or "/"
  app.get "/auth/linkedin", passport.authenticate("linkedin", state: "SOME STATE" )
  app.get "/auth/linkedin/callback", passport.authenticate("linkedin", failureRedirect: "/login"), (req, res) ->
    res.redirect req.session.returnTo or "/"
