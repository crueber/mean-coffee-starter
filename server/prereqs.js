global.logger = require('./config/logger')();
global.dir_loader = require('./dir_loader');
global.vent = new (require('events'))();
global.events = require('./events')();
global.app = require('express')();