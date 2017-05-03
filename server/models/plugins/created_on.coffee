module.exports = exports = createdOnPlugin = (schema, options) ->
  schema.add createdOn: Date
  schema.pre "save", (next) ->
    @createdOn = new Date  unless @createdOn
    next()
  
  schema.path("createdOn").index options.index  if options and options.index