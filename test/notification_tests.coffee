{Notification} = require '../src/notification'

{expect} = require 'chai'
sinon = require 'sinon'

exampleMessages =
  string: 'This is an example message.'
  object:
    message: 'This message is an example'

describe 'Notification', ->
  describe '#constructor', ->
    it 'should pass provided data to #set', ->
      sinon.spy Notification.prototype, 'set'

      notification = new Notification exampleMessages.string

      expect(notification.set.called).to.equal true

      Notification.prototype.set.restore()

    it 'should not call #set if no data is provided', ->
      sinon.spy Notification.prototype, 'set'

      notification = new Notification

      expect(notification.set.called).to.equal false

      Notification.prototype.set.restore()

  describe '#set', ->
    it 'should accept a string', ->
      notification = new Notification
      notification.set exampleMessages.string

      expect(notification.message).to.equal exampleMessages.string
      expect(typeof notification.message).to.equal 'string'

    it 'should accept an object', ->
      notification = new Notification
      notification.set exampleMessages.object

      expect(notification.message).to.equal JSON.stringify exampleMessages.object
      expect(typeof notification.message).to.equal 'string'
