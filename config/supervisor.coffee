
process.on 'uncaughtException', (err) ->
  if err.code is 'ECONNRESET'
    logger.error 'Requestor terminated the connection before a resopnse could be sent.'
  else
    logger.emerg 'UNCAUGHT EXCEPTION', err.stack 

process.once 'SIGUSR2', ->
  logger.warn 'Express received signal: SIGUSR2. Shutting down.'
  process.kill process.pid, 'SIGUSR2'
process.on 'SIGINT', ->
  logger.warn 'Express received signal: SIGINT. Shutting down.'
  process.exit()
process.on 'SIGTERM', ->
  logger.warn 'Express received signal: SIGTERM. Shutting down.'
  process.exit()

process.on 'exit', ->
  logger.info 'Express is shut down.'
