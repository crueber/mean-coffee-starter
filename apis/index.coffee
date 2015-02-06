path         = require 'path'
fs           = require 'fs'
express      = require 'express'
passportConf = require '../config/auth'

excludes = [ 'index', '.DS_Store' ]
apis = {}

###
# Load apis.
###
files = fs.readdirSync(__dirname)
for file in files
  name = path.basename(file, '.coffee')
  if excludes.indexOf(name) == -1
    logger.debug 'Loading api: ' + name
    apis[name] = require './' + name

module.exports = (app) ->
  router = express.Router()

  router.get "/api/linkedin", passportConf.isAuthenticated, passportConf.isAuthorized, apis.linkedin.getInfo
  
  router
