
UAParser = require('ua-parser-js') 
parser = new UAParser()

module.exports = (logger) -> 
  (req, res, next) ->
    user_agent = parser.setUA req.headers['user-agent']
    os = user_agent.getOS()
    browser = user_agent.getBrowser()

    logger.debug 'User Agent: ' + browser.name + ' ' + browser.major + ' on ' + os.name + ' ' + os.version

    next()
