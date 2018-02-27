
const updatedOnPlugin = (schema, options) => {
  schema.add({
    updatedOn: Date
  });
  schema.pre("save", function(next) {
    this.updatedOn = new Date;
    return next();
  });
  if (options && options.index) {
    return schema.path("updatedOn").index(options.index);
  }
};

module.exports = updatedOnPlugin