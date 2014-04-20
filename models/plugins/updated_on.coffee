module.exports = exports = updatedOnPlugin = (schema, options) ->
  schema.add updatedOn: Date
  schema.pre "save", (next) ->
    @updatedOn = new Date
    next()
  schema.path("updatedOn").index options.index  if options and options.index