# Returns a random 9GAG image
#
# 9gag me - Queries http://9gag.com/random and returns the image

jsdom = require("jsdom")
request = require("request")

module.exports = (robot) ->
  robot.respond /(9gag)( me)? (.*)/i, (msg) ->
    gagMe msg, msg.match[3], (url) ->
      msg.send url

gagMe = (msg, query, cb) ->
  request('http://9gag.com/random', (err, res, body) ->
      jsdom.env(body, ['http://code.jquery.com/jquery-1.6.min.js'], (errors, window) -> 
      	cb window.$("a[href='/random'] img").attr('src')
      )
  )

