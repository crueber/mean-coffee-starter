const UAParser = require('ua-parser-js');
const parser = new UAParser();

module.exports = (logger) => {
  return (req, res, next) => {
    const user_agent = parser.setUA(req.headers['user-agent']);
    const os = user_agent.getOS();
    const browser = user_agent.getBrowser();
    logger.debug(`User Agent: ${browser.name} ${browser.major} on ${os.name} ${os.version}`);
    return next();
  };
};
