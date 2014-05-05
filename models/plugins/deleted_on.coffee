module.exports = exports = deletedOnPlugin = (schema, options) ->
  schema.add
    deleted: Boolean
    deletedOn: Date

  schema.methods.soft_delete = (callback) ->
    @deleted = true
    @deletedOn = new Date
    @save callback

  if options and options.index
    schema.path("deleted").index options.index
    schema.path("deletedOn").index options.index