
const passport = require("passport");
require('./local');
require('./google');
require('./linkedin');

passport.serializeUser((user, done) => { return done(null, user.id); });

passport.deserializeUser((id, done) => {
  return User.findById(id, (err, user) => {
    return done(err, user);
  });
});

module.exports = {
  isAuthenticated: (req, res, next) => {
    if (req.isAuthenticated() && req.user.activated) { return next(); }
    return res.redirect("/login");
  },
  isAuthorized: (req, res, next) => {
    const provider = req.path.split("/").slice(-1)[0];
    if (_.find(req.user.tokens, { kind: provider })) {
      return next();
    }
    return res.redirect("/auth/" + provider);
  }
};
