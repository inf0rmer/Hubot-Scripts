# Messing around with the Dribbble API.
#
# dribbble me shots from <list> - Searches Dribble for the list and returns a random
#                                shot's image and link.
module.exports = (robot) ->
  robot.respond /(dribbble|db)( me shots from)? (.*)/i, (msg) ->
    list = msg.match[3]
    
    msg.http("http://api.dribbble.com/shots/#{list}")
      .get() (err, res, body) ->
        body = JSON.parse(body)
        shots = body.shots
        shot  = msg.random shots
        url = shot.url
        image = shot.image_url
        title = shot.title
		
        msg.send "<a href='#{url}'><img src='#{image}' />#{title}</a>"
