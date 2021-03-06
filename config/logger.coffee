winston = require 'winston'
colors = require 'colors'

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

formatter = (opt) ->
  color = if opt.colorize then log_levels.colors[opt.level] else "reset"
  i = "[#{moment().format()}] [PID:#{process.pid}] #{colors[color](opt.level.toUpperCase())} " + (opt.message or '')
  if opt.meta && Object.keys(opt.meta).length 
    i += '\n  '+ JSON.stringify(opt.meta)
  i

module.exports = ->
  client = new (winston.Logger)(levels: log_levels.levels)
  winston.addColors log_levels.colors
  client.add winston.transports.Console, level: log_level, colorize: true, timestamp: true, formatter: formatter

  client.logErr = (error) ->
    client.error error.message or "error", error.stack or error  if error
  client.logErrAndExit = (error) ->
    if error
      client.emerg error.message or "error", error.stack or error
      setTimeout process.exit, 2000, 1

  console.log = client.info

  client