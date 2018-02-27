
const deletedOnPlugin = (schema, options) => {
  schema.add({
    deleted: Boolean,
    deletedOn: Date
  });
  schema.methods.soft_delete = function(callback) {
    this.deleted = true;
    this.deletedOn = new Date;
    return this.save(callback);
  };
  if (options && options.index) {
    schema.path("deleted").index(options.index);
    return schema.path("deletedOn").index(options.index);
  }
};

module.exports = deletedOnPlugin;
