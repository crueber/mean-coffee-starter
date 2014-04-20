path = require 'path'
fs   = require 'fs'

excludes = [ 'index' ]
module.exports = models = {}

for file in fs.readdirSync(__dirname)
  name = path.basename(file, '.coffee')
  return if excludes.indexOf(name) != -1
  logger.debug 'Loading model: ' + name
  models[name] = require './' + name
  global[name] = models[name]
