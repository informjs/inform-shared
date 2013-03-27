_ = require 'lodash'

class Notification
  set: (data) ->
    if _.isObject data
      data = JSON.stringify data

    @message = data

module.exports = {
  Notification
}
