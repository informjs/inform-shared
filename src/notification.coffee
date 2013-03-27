_ = require 'lodash'

class Notification
  constructor: (data) ->
    @set data

  set: (data) ->
    if _.isObject data
      data = JSON.stringify data

    @message = data

module.exports = {
  Notification
}
