_ = require 'lodash'

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

module.exports = {
  Notification
}
