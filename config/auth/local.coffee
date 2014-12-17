passport         = require("passport")
LocalStrategy    = require("passport-local").Strategy
secrets          = require("../secrets")

passport.use new LocalStrategy(
  usernameField: "email"
, (email, password, done) ->
  User.findOne
    email: email
  , (err, user) ->
    unless user
      return done(null, false,
        message: "Email " + email + " not found"
      )
    user.comparePassword password, (err, isMatch) ->
      if isMatch
        done null, user
      else
        done null, false,
          message: "Invalid email or password."
)
