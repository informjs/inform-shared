_ = require 'lodash'
msgpack = require 'msgpack'
zmq = require 'zmq'

class Notification
  constructor: (data) ->
    if data? then @set data

  set: (data) -> @message = msgpack.pack data
  get: -> msgpack.unpack @message

  send: ->
    zmq.socket 'push'

module.exports = {
  Notification
}
