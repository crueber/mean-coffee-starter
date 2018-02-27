module.exports = (app) => {
  return vent.on(events.STARTUP_PREPARE, (app) => {
    const databases = [
      require('./mongodb')(app),
      require('./redis')(app)
    ];
    return Promise.all(databases).then(() => {
      return vent.emit(events.STARTUP_DATABASE_COMPLETE);
    }).catch((e) => {
      console.error(e);
      return vent.emit(events.SHUTDOWN);
    });
  });
};
