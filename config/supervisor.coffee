
process.on 'uncaughtException', (err) ->
  if err.code is 'ECONNRESET'
    logger.error 'Requestor terminated the connection before a resopnse could be sent.'
  else
    logger.emerg 'UNCAUGHT EXCEPTION', err.stack 

vent.on events.SERVER_LISTENING, ->
  logger.info "#{app.get('title')} server is listening on port #{app.get('port')} in #{app.get('env')} mode."

vent.on events.STARTUP_COMPLETE, ->
  process.once 'SIGUSR2', ->
    logger.warn 'Received SIGUSR2: Shutting down.'
    vent.emit events.APP_SHUTDOWN
    process.kill process.pid, 'SIGUSR2'
  process.on 'SIGINT', ->
    logger.warn 'Received SIGINT: Shutting down.'
    process.exit()
  process.on 'SIGTERM', ->
    logger.warn 'Received SIGTERM: Shutting down.'
    process.exit()
  process.on 'exit', ->
    vent.emit events.APP_SHUTDOWN
    logger.info app.get('title') + ' is shut down.'
