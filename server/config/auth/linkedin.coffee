passport         = require("passport")
LinkedInStrategy = require("passport-linkedin-oauth2").Strategy
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

passport.use new LinkedInStrategy(oauth_keys.linkedin, (req, accessToken, refreshToken, profile, done) ->
  if req.user
    User.findOne linkedin: profile.id
    , (err, existingUser) ->
      if existingUser
        done new Error "There is already a LinkedIn account that belongs to you. Sign in with that account or delete it, then link it with your current account."
      else
        User.findById req.user.id, (err, user) ->
          user.linkedin = profile.id
          user.tokens.push
            kind: "linkedin"
            accessToken: accessToken

          user.profile.name = user.profile.name or profile.displayName
          user.profile.location = user.profile.location or profile._json.location.name
          user.profile.picture = user.profile.picture or profile._json.pictureUrl
          user.profile.website = user.profile.website or profile._json.publicProfileUrl
          user.save (err) -> done err, user
  else
    User.findOne
      linkedin: profile.id
    , (err, existingUser) ->
      return done(null, existingUser)  if existingUser
      User.findOne
        email: profile._json.emailAddress
      , (err, existingEmailUser) ->
        if existingEmailUser
          done new Error "There is already an account using this email address. Sign in to that account and link it with LinkedIn manually from Account Settings."
        else
          user = new User()
          user.linkedin = profile.id
          user.tokens.push
            kind: "linkedin"
            accessToken: accessToken

          user.email = profile._json.emailAddress
          user.profile.name = profile.displayName
          user.profile.location = profile._json.location.name
          user.profile.picture = profile._json.pictureUrl
          user.profile.website = profile._json.publicProfileUrl
          user.save (err) ->
            done err, user
)
