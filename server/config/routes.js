
const controllers = require('../controllers');
const passportConf = require('./auth');
const passport = require('passport');
const express = require('express');
const api_router = require('../apis');

const auth_router = (app) => {
  const router = express.Router();
  // router.get "/logout", controllers.user.logout
  router.get("/auth/google", passport.authenticate("google", { scope: "profile email" }));
  router.get("/auth/google/callback", passport.authenticate("google", { failureRedirect: "/login", session: false }), (req, res) => {
    return res.redirect(req.session.returnTo || "/");
  });
  router.get("/auth/linkedin", passport.authenticate("linkedin", { state: "SOME STATE" }));
  router.get("/auth/linkedin/callback", passport.authenticate("linkedin", { failureRedirect: "/login", session: false }), (req, res) => {
    return res.redirect(req.session.returnTo || "/");
  });
  // router.post "/login", controllers.user.postLogin
  // router.post "/signup", controllers.user.postSignup
  router.post("/forgot", controllers.user.postForgot);
  router.post("/reset/:token", controllers.user.postReset);
  // router.post('/account/delete', passportConf.isAuthenticated, controllers.user.postDeleteAccount);
  // router.post "/account/profile", passportConf.isAuthenticated, controllers.user.postUpdateProfile
  // router.get "/account/removePicture", passportConf.isAuthenticated, controllers.user.removePicture
  // router.post "/account/password", passportConf.isAuthenticated, controllers.user.postUpdatePassword
  // router.get "/account/unlink/:provider", passportConf.isAuthenticated, controllers.user.getOauthUnlink
  return router;
};

page_router = function(app) {
  const router = express.Router();
  // router.get "/", passportConf.isAuthenticated, controllers.home.index
  return router;
};

module.exports = function(app) {
  return vent.on(events.STARTUP_ROUTES, () => {
    app.use('/api', [api_router(app)]);
    app.use('/', [page_router(app), auth_router(app)]);
    return vent.emit(events.STARTUP_ROUTES_COMPLETE);
  });
};
