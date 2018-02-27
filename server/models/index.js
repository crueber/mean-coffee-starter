const path = require('path');
const fs = require('fs');

logger.debug('Loading models...');
const excludes = ['index', 'plugins'];
const models = {};

module.exports = models;

ref = fs.readdirSync(__dirname);
for (i = 0, len = ref.length; i < len; i++) {
  file = ref[i];
  name = path.basename(file, '.coffee');
  if (excludes.indexOf(name) === -1) {
    logger.debug('Loading model: ' + name);
    models[name] = require('./' + name);
    global[name] = models[name];
  }
}
