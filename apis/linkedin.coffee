oauth_keys  = require("../config/oauth_keys")
validator   = require("validator")
request     = require("request")

###
GET /api
List of API examples.
###
# exports.getApi = (req, res) ->
#   res.render "api/index",
#     title: "API Examples"

###
GET /api/scraping
Web scraping example using Cheerio library.
###
# exports.getScraping = (req, res, next) ->
#   request.get "https://news.ycombinator.com/", (err, request, body) ->
#     return next(err)  if err
#     $ = cheerio.load(body)
#     links = []
#     $(".title a[href^='http'], a[href^='https']").each ->
#       links.push $(this)
#       return
#     res.render "api/scraping",
#       title: "Web Scraping"
#       links: links

###
GET /api/linkedin
LinkedIn API example.
###
# exports.getInfo = (req, res, next) ->
#   token = _.find req.user.tokens, kind: "linkedin"
#   linkedin = Linkedin.init(token.accessToken)
#   linkedin.people.me (err, $in) ->
#     return next(err)  if err
#     res.render "api/linkedin", title: "LinkedIn API", profile: $in
