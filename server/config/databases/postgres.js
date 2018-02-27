const pg = require('pg');

module.exports = (app) => {
  return new Promise((res, rej) => {
    if (!app.get('postgres_db')) { return rej(new Error("Postgres connection string not found.")); }
    return pg.connect(app.get('postgres_db'), (err, client, done) => {
      app.set('postgres_client', client);
      vent.emit(events.POSTGRES_CONNECTED, client);
      vent.on(events.APP_SHUTDOWN, () => {
        done();
        logger.info('Postgres connection disconnected gracefully.');
        return vent.emit(events.POSTGRES_DISCONNECTED);
      });
      return res();
    });
  });
};
