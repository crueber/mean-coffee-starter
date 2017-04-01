path = require 'path'
fs   = require 'fs'

logger.debug 'Loading models...'

excludes = [ 'index', 'plugins' ]
module.exports = models = {}

for file in fs.readdirSync(__dirname)
  name = path.basename(file, '.coffee')
  if excludes.indexOf(name) == -1
    logger.debug 'Loading model: ' + name
    models[name] = require './' + name
    global[name] = models[name]
