# Messing around with the Dribbble API.
#
# dribbble me shots from <list> - Searches Dribble for the list and returns a random
#                                shot's image and link.
module.exports = (robot) ->
  robot.respond /(dribbble|db)( me shots from)? (.*)/i, (msg) ->
    list = msg.match[3]
    allowedLists = ['everyone', 'debut', 'popular']

    isAllowed = allowedLists.some (allowed) -> list is allowed
    
    unless isAllowed
       msg.send('This list does not exist, check your spelling?')
       return false
    
    msg.http("http://api.dribbble.com/shots/#{list}")
      .get() (err, res, body) ->
        body = JSON.parse(body)
        shots = body.shots
        
        if shots and shots.length
            shot  = msg.random shots
            url = shot.url
            image = shot.image_url
            title = shot.title
            msg.send title
            msg.send url
            msg.send image
        else
            msg.send "Sorry, no shots!"