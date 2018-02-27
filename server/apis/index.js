const express = require('express');

const apis = dir_loader(__dirname, { prefix: 'api routes', excludes: ['index', '.DS_Store'] });

const insecure_routes = (router) => {
  router.post('/login', apis.user.post_login);
  router.post('/user', apis.user.verify_local_prereqs, apis.user.post_user);
  return router;
};

const secure_routes = (router) => {
  router.use(apis.user.verify_auth);
  router.get('/user', apis.user.get_user);
  router.put('/user', apis.user.update_user);
  router.post('/user/password', apis.user.post_user_password);
  router.delete('/user', apis.user.delete_user);
  return router;
};

const module.exports = (app) => {
  const router = express.Router();
  router.use(insecure_routes(express.Router()));
  router.use(secure_routes(express.Router()));
  return router;
};
