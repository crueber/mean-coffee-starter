_                = require("underscore")
passport         = require("passport")
LocalStrategy    = require("passport-local").Strategy
GoogleStrategy   = require("passport-google-oauth").OAuth2Strategy
LinkedInStrategy = require("passport-linkedin-oauth2").Strategy
User             = require("../models/User")
secrets          = require("./secrets")

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    done err, user

# Sign in using Email and Password.
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

# Sign in with Google.
passport.use new GoogleStrategy(secrets.google, (req, accessToken, refreshToken, profile, done) ->
  if req.user
    User.findOne
      $or: [
        { google: profile.id }
        { email: profile.email }
      ]
    , (err, existingUser) ->
      if existingUser
        req.flash "errors",
          msg: "There is already a Google account that belongs to you. Sign in with that account or delete it, then link it with your current account."

        done err
      else
        User.findById req.user.id, (err, user) ->
          user.google = profile.id
          user.tokens.push
            kind: "google"
            accessToken: accessToken

          user.profile.name = user.profile.name or profile.displayName
          user.profile.gender = user.profile.gender or profile._json.gender
          user.profile.picture = user.profile.picture or profile._json.picture
          user.save (err) ->
            req.flash "info",
              msg: "Google account has been linked."

            done err, user
  else
    User.findOne
      google: profile.id
    , (err, existingUser) ->
      return done(null, existingUser)  if existingUser
      User.findOne
        email: profile._json.email
      , (err, existingEmailUser) ->
        if existingEmailUser
          req.flash "errors",
            msg: "There is already an account using this email address. Sign in to that account and link it with Google manually from Account Settings."

          done err
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

# Sign in with LinkedIn.
passport.use new LinkedInStrategy(secrets.linkedin, (req, accessToken, refreshToken, profile, done) ->
  if req.user
    User.findOne
      $or: [
        { linkedin: profile.id }
        { email: profile._json.emailAddress }
      ]
    , (err, existingUser) ->
      if existingUser
        req.flash "errors",
          msg: "There is already a LinkedIn account that belongs to you. Sign in with that account or delete it, then link it with your current account."

        done err
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
          user.save (err) ->
            req.flash "info",
              msg: "LinkedIn account has been linked."

            done err, user
  else
    User.findOne
      linkedin: profile.id
    , (err, existingUser) ->
      return done(null, existingUser)  if existingUser
      User.findOne
        email: profile._json.emailAddress
      , (err, existingEmailUser) ->
        if existingEmailUser
          req.flash "errors",
            msg: "There is already an account using this email address. Sign in to that account and link it with LinkedIn manually from Account Settings."

          done err
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

# Login Required middleware.
exports.isAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"


# Authorization Required middleware.
exports.isAuthorized = (req, res, next) ->
  provider = req.path.split("/").slice(-1)[0]
  if _.findWhere(req.user.tokens, kind: provider)
    next()
  else
    res.redirect "/auth/" + provider