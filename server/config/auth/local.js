
const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;

passport.use(new LocalStrategy({ usernameField: "email" }, (email, password, done) => {
  return User.findOne({ email: email }, (err, user) => {
    if (!user) { return done(null, false, { message: "Email " + email + " not found" }); }
    return user.comparePassword(password, (err, isMatch) => {
      if (isMatch) { return done(null, user); }
      return done(null, false, { message: "Invalid email or password." });
    });
  });
}));
