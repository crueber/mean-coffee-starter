const bluebird = require('bluebird');
const mongoose = require('mongoose');

module.exports = (app) => {
  return new Promise((res, rej) => {
    if (!app.get('mongo_db')) { return rej(new Error("Mongo connection string not found.")); }

    mongoose.Promise = bluebird;
    mongoose.set('debug', app.get('env') === 'development');
    mongoose.connect(app.get('mongo_db'));
    mongoose.connection.on('error', () => { return logger.error('MongoDB Connection Error'); });
    mongoose.connection.on('disconnecting', () => { return logger.info('MongoDB is disconnecting...'); });
    mongoose.connection.on('disconnected', () => { return logger.info('MongoDB connection has successfully closed.'); });
    mongoose.connection.on('connected', () => {
      logger.info('MongoDB Connection Established');
      require('../../models');
      vent.emit(events.MONGO_CONNECTED);
      return res();
    });
    vent.on(events.APP_SHUTDOWN, () => {
      mongoose.disconnect();
      logger.info('Mongo disconnected gracefully.');
      return vent.emit(events.MONGO_DISCONNECTED);
    });
  });
};
