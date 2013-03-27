_ = require 'lodash'

class Notification
  constructor: (data) ->
    if data? then @set data

  set: (data) ->
    if _.isObject data
      data = JSON.stringify data

    @message = data

module.exports = {
  Notification
}
