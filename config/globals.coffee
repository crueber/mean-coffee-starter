path = require("path")

global.constant = {}
global.constant.one_ms     = 1
global.constant.one_second = constant.one_ms * 1000
global.constant.one_minute = constant.one_second * 60
global.constant.one_hour   = constant.one_minute * 60
global.constant.one_day    = constant.one_hour * 24
global.constant.one_week   = constant.one_hour * 7

###
# Application Globals Setup
###
module.exports = (app) ->
  application_globals =
    'port':        process.env.PORT or 3000
    'mongo_db':    process.env.MONGODB or "mongodb://localhost:27017/meanstart"
    'views':       path.join(__dirname, "/../views")
    'view engine': 'jade'
    'title':       'MEAN Coffee Baseline'

  app.set key, value for key, value of application_globals

