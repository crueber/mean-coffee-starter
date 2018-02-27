const winston = require('winston');
const colors = require('colors');
const moment = require('moment');
const log_level = process.env.LOG_LEVEL || 'debug';

const log_levels = {
  levels: { debug: 0, info: 1, warn: 2, error: 3, emerg: 4 },
  colors: { debug: "cyan", info: "green", warn: "yellow", error: "red", emerg: "red" }
};

const formatter = (opt) => {
  const color = opt.colorize ? log_levels.colors[opt.level] : "reset";
  let i = ("[" + (moment().format()) + "] [PID:" + process.pid + "] " + (colors[color](opt.level.toUpperCase())) + " ") + (opt.message || '');
  if (opt.meta && Object.keys(opt.meta).length) {
    i += '\n  ' + JSON.stringify(opt.meta);
  }
  return i;
};

module.exports = function() {
  const client = new winston.Logger({ levels: log_levels.levels });
  winston.addColors(log_levels.colors);
  client.add(winston.transports.Console, {
    level: log_level,
    colorize: true,
    timestamp: true,
    formatter: formatter
  });
  client.logErr = function(error) {
    if (error) { return client.error(error.message || "error", error.stack || error); }
  };
  client.logErrAndExit = function(error) {
    if (error) {
      client.emerg(error.message || "error", error.stack || error);
      return setTimeout(process.exit, 2000, 1);
    }
  };
  console.log = client.info;
  return client;
};
