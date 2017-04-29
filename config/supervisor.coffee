
process.on 'uncaughtException', (err) ->
  if err.code is 'ECONNRESET'
    logger.error 'Requestor terminated the connection before a resopnse could be sent.'
  else
    logger.emerg 'UNCAUGHT EXCEPTION', err.stack 

events.on 'server-listening', ->
  logger.info "#{app.get('title')} server is listening on port #{app.get('port')} in #{app.get('env')} mode."

events.on 'startup-complete', ->
  process.once 'SIGUSR2', ->
    logger.warn 'Received SIGUSR2: Shutting down.'
    events.emit 'shutdown'
    process.kill process.pid, 'SIGUSR2'
  process.on 'SIGINT', ->
    logger.warn 'Received SIGINT: Shutting down.'
    process.exit()
  process.on 'SIGTERM', ->
    logger.warn 'Received SIGTERM: Shutting down.'
    process.exit()
  process.on 'exit', ->
    events.emit 'shutdown'
    logger.info app.get('title') + ' is shut down.'
