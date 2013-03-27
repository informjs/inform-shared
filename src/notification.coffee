_ = require 'lodash'
msgpack = require 'msgpack'
zmq = require 'zmq'

class Notification
  constructor: (data) ->
    if data? then @set data

  set: (data) -> @message = msgpack.pack data
  get: -> msgpack.unpack @message

  send: ->
    socket = zmq.socket 'push'
    socket.connect 'tcp://127.0.0.1:5000'

    socket.send @message

module.exports = {
  Notification
}
