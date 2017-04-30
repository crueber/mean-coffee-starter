
path         = require 'path'
fs           = require 'fs'

module.exports = (dir, opts = {}) ->
  opts.args ?= []
  opts.excludes ?= []
  loaded = {}

  dir = path.resolve(dir)
  files = fs.readdirSync(dir)

  for file in files
    file_details = fs.statSync path.resolve dir, file
    if not file_details.isDirectory()
      name = path.basename file, '.coffee'
      if opts.excludes.indexOf(name) isnt -1
        logger.debug "Loading: #{name}"
        loaded[name] = require path.resolve dir, name
        if typeof loaded[name] is 'function'
          loaded[name].call(opts.args) 

  loaded
