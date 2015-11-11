winston = require("winston")

module.exports = ->
  log_level = process.env.LOG_LEVEL || 'debug'
  log_levels =
    levels:
      debug: 0
      info: 1
      warn: 2
      error: 3
      emerg: 4
    colors:
      debug: "cyan"
      info: "green"
      warn: "yellow"
      error: "red"
      emerg: "red"

  console_transport = new (winston.transports.Console)(level: log_level, colorize: true, timestamp: true)
  client = new (winston.Logger)(levels: log_levels.levels, transports: [console_transport])
  winston.addColors log_levels.colors

  client.logErr = (error) ->
    client.error error.message or "error", error.stack or error  if error
  client.logErrAndExit = (error) ->
    if error
      client.emerg error.message or "error", error.stack or error
      setTimeout process.exit, 2000, 1

  console.log = client.info

  client