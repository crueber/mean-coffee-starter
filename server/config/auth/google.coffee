passport         = require("passport")
GoogleStrategy   = require("passport-google-oauth").OAuth2Strategy
oauth_keys       = require("../oauth_keys")

###
OAuth Strategy Overview

- User is already logged in.
- Check if there is an existing account with a provider id or email.
- If there is, return an error message. (Account merging not supported)
- Else link new OAuth account with currently logged-in user.
- User is not logged in.
- Check if it's a returning user.
- If returning user, sign in and we are done.
- Else check if there is an existing account with user's email.
- If there is, return an error message.
- Else create a new account.
###

passport.use new GoogleStrategy(oauth_keys.google, (req, accessToken, refreshToken, profile, done) ->
  if req.user
    User.findOne
      $or: [
        { google: profile.id }
        { email: profile.email }
      ]
    , (err, existingUser) ->
      if existingUser
        done new Error "There is already a Google account that belongs to you. Sign in with that account or delete it, then link it with your current account."
      else
        User.findById req.user.id, (err, user) ->
          user.google = profile.id
          user.tokens.push
            kind: "google"
            accessToken: accessToken

          user.profile.name = user.profile.name or profile.displayName
          user.profile.gender = user.profile.gender or profile._json.gender
          user.profile.picture = user.profile.picture or profile._json.picture
          user.save (err) -> done err, user
  else
    User.findOne
      google: profile.id
    , (err, existingUser) ->
      return done(null, existingUser)  if existingUser
      User.findOne
        email: profile._json.email
      , (err, existingEmailUser) ->
        if existingEmailUser
          done new Error "There is already an account using this email address. Sign in to that account and link it with Google manually from Account Settings."
        else
          user = new User()
          user.email = profile._json.email
          user.google = profile.id
          user.tokens.push
            kind: "google"
            accessToken: accessToken

          user.profile.name = profile.displayName
          user.profile.gender = profile._json.gender
          user.profile.picture = profile._json.picture
          user.save (err) ->
            done err, user
)
