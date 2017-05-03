
module.exports = (req, res, next) ->
  if _.contains req.path, '/health_check'
    res.sendStatus 200
    logger.debug 'Health check caught.'
  else
    next()
