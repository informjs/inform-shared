{Notification} = require 'inform/lib/inform/notification'

{expect} = require 'chai'

exampleMessages =
  string: 'This is an example message.'
  object:
    message: 'This message is an example'

describe 'Notification', ->
  describe '#set', ->
    it 'should accept a string', ->
      notification = new Notification
      notification.set exampleMessages.string

      expect(notification.message).to.equal exampleMessages.string
      expect(typeof notification.message).to.equal 'string'
