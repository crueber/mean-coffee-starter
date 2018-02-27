
const bodyParser = require("body-parser");
const compress = require("compression");
const express = require("express");
const expressValidator = require("express-validator");
const methodOverride = require("method-override");
const passport = require("passport");
const path = require("path");
const session = require("express-session");

const middleware = dir_loader(__dirname + '/middleware', { curried: false, prefix: 'middleware' });

module.exports = (app) => {
  vent.on(events.STARTUP_MIDDLEWARE, () => {
    const buildDir = app.get('env') !== 'production' ? false : ".tmp";
    app.use(middleware.health_check);
    app.use(middleware.request_logger(logger));
    app.use(compress());
    app.use(middleware.user_agent_check(logger));
    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({ extended: true }));
    app.use(expressValidator());
    app.use(methodOverride('X-HTTP-Method-Override'));
    app.use(passport.initialize());
    vent.emit(events.STARTUP_MIDDLEWARE_COMPLETE);
  });
};
