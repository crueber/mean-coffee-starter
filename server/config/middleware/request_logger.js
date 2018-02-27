
const onFinished = require('on-finished');

module.exports = (logger) => {
  return (req, res, next) => {
    const url = () => { return req.originalUrl || req.url; };
    const method = () => { return req.method; };
    const status = () => {
      if (res._header) { return res.statusCode; }
      return null;
    };
    const content_length = () => {
      if (res['content-length']) { return ' - ' + res['content-length']; }
      return '';
    };
    req._startAt = process.hrtime();
    onFinished(res, () => {
      var response_time;
      response_time = () => {
        if (!res._header || !req._startAt) { return ''; }
        const diff = process.hrtime(req._startAt);
        const ms = diff[0] * 1e3 + diff[1] * 1e-6;
        return ' ' + ms.toFixed(3) + 'ms';
      };
      return logger.debug(`${method()} ${url()} ${status()}${response_time()}${content_length()}`);
    });
    return next();
  };
};
