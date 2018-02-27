
const controllers = require('../controllers');

module.exports = (app) => {
  return vent.on(events.STARTUP_COMPLETE, () => {
    return app.use((req, res) => {
      return res.status(404).end();
    });
  });
};
