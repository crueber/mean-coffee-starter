onFinished = require 'on-finished'

module.exports = (logger) -> 
  (req, res, next) ->
    url            = -> req.originalUrl or req.url
    method         = -> req.method
    status         = -> if res._header then res.statusCode else null
    content_length = -> if res['content-length'] then ' - ' + res['content-length'] else ''
    req._startAt = process.hrtime()

    onFinished res, ->
      response_time = ->
        return '' if (!res._header || !req._startAt)
        diff = process.hrtime(req._startAt);
        ms = diff[0] * 1e3 + diff[1] * 1e-6
        ' ' + ms.toFixed(3) + 'ms'

      logger.debug method() + ' ' + url() + ' ' + status() + response_time() + content_length()
    next()