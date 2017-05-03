
# Heroku setup

if !process.env.DYNO or process.env.DYNO is 'web.1' or process.env.RUN_CRON

  CronJob = require('cron').CronJob

  logger.info 'Adding daily cron job.'
  job = new CronJob
    cronTime: '00 40 01 * * *'
    onTick: ->
      # Runs every day at 1:30:00 AM.
      logger.info 'Cron tick'
    start: true,
    timeZone: 'America/Chicago'
