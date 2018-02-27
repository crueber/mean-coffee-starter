const path = require('path');
const fs = require('fs');

module.exports = async (dir, opts = {}) => {
  const options = { args: [], excludes: [], prefix: '', curried: true, ...opts };
  const loaded = {};

  const dir = path.resolve(dir)
  const files = await fs.readdir(dir)
  for (let file of files) {
    const file_details = await fs.stat(path.resolve(dir, file));
    if (file_details.isDirectory()) continue;

    const name = path.basename(file, '.js');
    if (opts.excludes.indexOf(name) !== -1) continue;

    logger.debug(`${opts.prefix}: ${name}`);
    loaded[name] = require(path.resolve(dir, name))

    if (typeof loaded[name] === 'function' && opts.curried) {
      loaded[name].apply(this, opts.args);
    }
  }

  return loaded;
};
