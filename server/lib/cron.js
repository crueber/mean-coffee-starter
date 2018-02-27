
if (!process.env.DYNO || process.env.DYNO === 'web.1' || process.env.RUN_CRON) {
  const CronJob = require('cron').CronJob;

  logger.info('Adding daily cron job.');
  const job = new CronJob({
    cronTime: '00 40 01 * * *',
    onTick: function() { return logger.info('Cron tick'); },
    start: true,
    timeZone: 'America/Chicago'
  });
}
