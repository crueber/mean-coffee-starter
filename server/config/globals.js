const path = require('path');

const set_globals = (app) => {
  global._ = require('lodash');
  global.Promise = require('bluebird');
  global.moment = require('moment');
  global.empty_fn = () => { return null; };
  global.constant = {};
  global.constant.one_ms = 1;
  global.constant.one_second = constant.one_ms * 1000;
  global.constant.one_minute = constant.one_second * 60;
  global.constant.one_hour = constant.one_minute * 60;
  global.constant.one_day = constant.one_hour * 24;
  global.constant.one_week = constant.one_day * 7;
  global.constant.one_month = constant.one_day * 30;
  global.constant.one_year = constant.one_day * 365;
  global.constant.one_byte = 1;
  global.constant.one_kb = 1024 * global.constant.one_byte;
  global.constant.one_mb = 1024 * global.constant.one_kb;
  global.constant.one_gb = 1024 * global.constant.one_mb;
  const application_globals = {
    'dev': app.get('env') !== 'production',
    'views': path.join(__dirname, "/../views"),
    'view engine': 'pug',
    'title': 'MEAN Coffee Baseline',
    'port': process.env.PORT,
    'sessionSecret': process.env.SESSION_SECRET,
    'mail_host': process.env.MAIL_HOST,
    'mail_port': process.env.MAIL_PORT,
    'mail_username': process.env.MAIL_USERNAME,
    'mail_password': process.env.MAIL_PASSWORD,
    'mongo_db': process.env.MONGODB || 'mongodb://192.168.99.100:27017/mean-coffee-starter',
    'redis_host': process.env.REDISHOST || '192.168.99.100',
    'redis_port': process.env.REDISPORT || 6379
  };
  for (const key in application_globals) {
    const value = application_globals[key];
    app.set(key, value);
  }
  app.locals.title = application_globals['title'];
  return app.locals.dev = application_globals['dev'];
};

module.exports = (app) => {
  return vent.on(events.STARTUP_PREPARE, () => {
    return set_globals(app);
  });
};
