_ = require 'lodash'
zmq = require 'zmq'

class Notification
  constructor: (data) ->
    if data? then @set data

  set: (data) ->
    if _.isObject data
      data = JSON.stringify data
      @dataType = 'json'

    else
      @dataType = 'raw'

    @message = data

  get: ->
    switch @dataType
      when 'json' then return JSON.parse @message
      when 'raw' then return @message

  send: ->
    zmq.socket 'push'

module.exports = {
  Notification
}
