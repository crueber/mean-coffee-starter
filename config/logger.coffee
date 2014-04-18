winston = require("winston")

log_levels =
  levels:
    debug: 0
    info: 1
    warn: 2
    error: 3
    emerg: 4
  colors:
    debug: "grey"
    info: "green"
    warn: "yellow"
    error: "red"
    emerg: "red"

module.exports = (app) ->

  console_transport = new (winston.transports.Console)(level: "debug", colorize: true, timestamp: true)
  client = new (winston.Logger)(levels: log_levels.levels, transports: [console_transport])
  winston.addColors log_levels.colors

  client.logErr = (error) ->
    client.error error.message or "error", error.stack or error  if error
  client.logErrAndExit = (error) ->
    if error
      client.emerg error.message or "error", error.stack or error
      setTimeout process.exit, 2000, 1

  client