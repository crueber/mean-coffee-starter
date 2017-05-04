
set_jwt_from_user = (user, res) ->
  user.generate_jwt()
  .then (jwt) ->
    res.set 'Token': jwt
    res.json token: jwt
  .catch (err) ->
    res.status(500).json err


module.exports = 
  verify_local_prereqs: (req, res, next) ->
    req.assert("email", "Email is not valid").isEmail()
    req.assert("password", "Password cannot be blank").notEmpty()
    return next() unless errors = req.validationErrors()

    res.status(403).json errors

  post_login: (req, res, next) ->
    passport.authenticate("local", (err, user, info) ->
      return next(err) if err
      set_jwt_from_user user, res
    ) req, res, next

    # Verify user, and generate the JWT.

  post_user: (req, res, next) ->
    req.assert("email", "Email is not valid").isEmail()
    req.assert("password", "Password must be at least 4 characters long").len 4
    req.assert("confirmPassword", "Passwords do not match").equals req.body.password
    return res.status(404).json(errors) if errors = req.validationErrors()

    User.create email: req.body.email, password: req.body.password
    .then (user) ->
      set_jwt_from_user user, res
    .catch (err) ->
      res.status(404).json err

  get_user: (req, res) ->
    res.json req.user

  update_user: (req, res) ->
    User.findById req.user.id, (err, user) ->
    .then (user) ->
      user.email = req.body.email or user.email
      user.profile.name = req.body.name or user.profile.name
      user.profile.gender = req.body.gender or user.profile.gender
      user.profile.location = req.body.location or user.profile.location
      user.profile.website = req.body.website or user.profile.website
      user.save().then ->
        res.json user: user
  
  post_user_password: (req, res, next) ->
    req.assert("password", "Password must be at least 4 characters long").len 4
    req.assert("confirmPassword", "Passwords do not match").equals req.body.password
    return res.status(404).json errors if errors = req.validationErrors()

    User.findById req.user.id
    .then (user) ->
      user.password = req.body.password
      user.save().then ->
        res.status(200).end()

  delete_user: (req, res) ->
    User.remove _id: req.user.id
    .then ->
      res.status(200).end()
    .catch (err) ->
      res.status(404).json err

  # getOauthUnlink: (req, res, next) ->
  #   provider = req.params.provider
  #   User.findById req.user.id, (err, user) ->
  #     return next(err)  if err
  #     user[provider] = `undefined`
  #     user.tokens = _.reject(user.tokens, (token) ->
  #       token.kind is provider
  #     )
  #     user.save (err) ->
  #       return next(err)  if err
  #       res.redirect "/account"
