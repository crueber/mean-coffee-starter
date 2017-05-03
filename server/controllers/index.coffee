path = require 'path'
fs   = require 'fs'

excludes = [ 'index', '.DS_Store' ]
controllers = {}

###
# Load controllers.
###
files = fs.readdirSync(__dirname)
for file in files
  name = path.basename(file, '.coffee')
  if excludes.indexOf(name) == -1
    logger.debug 'Loading controller: ' + name
    controllers[name] = require './' + name

module.exports = controllers
