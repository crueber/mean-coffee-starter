
path         = require 'path'
fs           = require 'fs'

module.exports = (dir, opts = {}) ->
  opts.args ?= []
  opts.excludes ?= []
  opts.prefix = if opts.prefix then 'Loading '+opts.prefix else 'Loading'
  opts.curried ?= true
  loaded = {}

  dir = path.resolve(dir)
  files = fs.readdirSync(dir)

  for file in files
    file_details = fs.statSync path.resolve dir, file
    if not file_details.isDirectory()
      name = path.basename file, '.coffee'
      if opts.excludes.indexOf(name) is -1
        logger.debug "#{opts.prefix}: #{name}"
        loaded[name] = require path.resolve dir, name
        if typeof loaded[name] is 'function' and opts.curried
          loaded[name].apply @, opts.args

  loaded
