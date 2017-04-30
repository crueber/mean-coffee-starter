
module.exports = ->
  STARTUP_PREPARE: 'startup-prepare'
  STARTUP_DATABASE_COMPLETE: 'startup-database-complete'
  STARTUP_MIDDLEWARE: 'startup-middleware'
  STARTUP_MIDDLEWARE_COMPLETE: 'startup-middleware-complete'
  STARTUP_ROUTES: 'startup-routes'
  STARTUP_ROUTES_COMPLETE: 'startup-routes-complete'
  STARTUP_COMPLETE: 'startup-complete'

  MONGO_CONNECTED: 'db-mongo-connected'
  MONGO_DISCONNECTED: 'db-mongo-disconnected'
  POSTGRES_CONNECTED: 'db-postgres-connected'
  POSTGRES_DISCONNECTED: 'db-postgres-disconnected'
  REDIS_CONNECTED: 'db-redis-connected'
  REDIS_DISCONNECTED: 'db-redis-disconnected'

  SERVER_LISTENING: 'server-listening'
  SHUTDOWN: 'shutdown-requested'
  APP_SHUTDOWN: 'shutdown-prepare'

