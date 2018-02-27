const redis = require('redis');

module.exports = (app) => {
  return new Promise((res, rej) => {
    if (!app.get('redis_host')) { return rej(new Error("Unable to find redis connection string.")); }
    const host = app.get('redis_host');
    const port = app.get('redis_port');
    const opts = app.get('redis_opts');
    const auth = app.get('redis_auth');
    const redis_client = redis.createClient(port, host, opts || {});
    if (auth) { redis_client.auth(auth); }
    if (app.get('redisdb')) { redis_client.select(app.get('redisdb')); }

    redis_client.on('connect', function() {
      if (app.get('redisdb')) {
        redis_client.send_anyways = true;
        redis_client.select(app.get('redisdb'));
        redis_client.send_anyways = false;
      }
      app.set('redis_client', redis_client);
      logger.info('Connection established to redis.');
      vent.emit(events.REDIS_CONNECTED);
      return res();
    });
    redis_client.on('ready', function() { return logger.info('Redis is ready.'); });
    redis_client.on('end', function() { return logger.info('Connection to redis has been closed.'); });
    return vent.on(events.APP_SHUTDOWN, function() {
      redis_client.quit();
      logger.info('Redis connection gracefully disconnected.');
      return vent.emit(events.REDIS_DISCONNECTED);
    });
  });
};
