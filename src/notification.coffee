_ = require 'lodash'
zmq = require 'zmq'


class Notification
  constructor: (data) ->
    if data? then @set data

  set: (data) -> @message = JSON.stringify data
  get: -> JSON.parse @message

  send: ->
    socket = zmq.socket 'push'
    socket.connect 'tcp://127.0.0.1:5000'

    socket.send @message


module.exports = {
  Notification
}
