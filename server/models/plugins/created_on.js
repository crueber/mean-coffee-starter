
const createdOnPlugin = function(schema, options) {
  schema.add({
    createdOn: Date
  });
  schema.pre("save", function(next) {
    if (!this.createdOn) {
      this.createdOn = new Date;
    }
    return next();
  });
  if (options && options.index) {
    return schema.path("createdOn").index(options.index);
  }
};

module.exports = createdOnPlugin;
