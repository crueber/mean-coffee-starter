
const set_jwt_from_user = (user, res) => {
  return user.generate_jwt().then((jwt) => {
    res.set({
      'Token': jwt
    });
    return res.json({
      token: jwt
    });
  }).catch((err) => {
    return res.status(500).json(err);
  });
};

module.exports = {
  verify_auth: (req, res, next) => {},
  verify_local_prereqs: (req, res, next) => {
    req.assert("email", "Email is not valid").isEmail();
    req.assert("password", "Password cannot be blank").notEmpty();
    const errors = req.validationErrors();
    if (!errors) { return next(); }
    return res.status(403).json(errors);
  },
  post_login: (req, res, next) => {
    return passport.authenticate("local", {
      session: false
    }, (err, user, info) => {
      if (err) { return next(err); }
      return set_jwt_from_user(user, res);
    })(req, res, next);
  },
  post_user: (req, res, next) => {
    req.assert("email", "Email is not valid").isEmail();
    req.assert("password", "Password must be at least 4 characters long").len(4);
    req.assert("confirmPassword", "Passwords do not match").equals(req.body.password);
    const errors = req.validationErrors();
    if (errors) { return res.status(404).json(errors); }
    return User.create({ email: req.body.email, password: req.body.password }).then(function(user) {
      return set_jwt_from_user(user, res);
    }).catch((err) => {
      return res.status(404).json(err);
    });
  },
  get_user: (req, res) => {
    return res.json(req.user);
  },
  update_user: (req, res) => {
    return User.findById(req.user.id).then((user) => {
      user.email = req.body.email || user.email;
      user.profile.name = req.body.name || user.profile.name;
      user.profile.gender = req.body.gender || user.profile.gender;
      user.profile.location = req.body.location || user.profile.location;
      user.profile.website = req.body.website || user.profile.website;
      return user.save().then(() => {
        return res.json({ user });
      });
    });
  },
  post_user_password: (req, res, next) => {
    req.assert("password", "Password must be at least 4 characters long").len(4);
    req.assert("confirmPassword", "Passwords do not match").equals(req.body.password);
    const errors = req.validationErrors();
    if (errors) { return res.status(404).json(errors); }
    return User.findById(req.user.id).then((user) => {
      user.password = req.body.password;
      return user.save().then(() => {
        return res.status(200).end();
      });
    });
  },
  delete_user: (req, res) => {
    return User.remove({ _id: req.user.id }).then(function() {
      return res.status(200).end();
    }).catch(function(err) {
      return res.status(404).json(err);
    });
  }
};
