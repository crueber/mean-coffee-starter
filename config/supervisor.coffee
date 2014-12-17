
process.on 'uncaughtException', (err) ->
  if err.code is 'ECONNRESET'
    logger.error 'Requestor terminated the connection before a resopnse could be sent.'
  else
    logger.emerg 'UNCAUGHT EXCEPTION', err.stack 


events.on 'ready', ->
  logger.info(app.get('title') + " server is listening on port %d in %s mode", app.get('port'), app.get('env'));

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
