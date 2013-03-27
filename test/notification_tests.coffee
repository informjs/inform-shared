{Notification} = require '../src/notification'

{expect} = require 'chai'
sinon = require 'sinon'
zmq = require 'zmq'

exampleMessages =
  string: 'This is an example message.'
  array: ['This message is an example.']
  object:
    message: 'This message is an example.'

describe 'Notification', ->
  describe '#constructor', ->
    it 'should pass provided data to #set', ->
      sinon.spy Notification.prototype, 'set'

      notification = new Notification exampleMessages.string

      expect(notification.set.calledOnce).to.be.true

      Notification.prototype.set.restore()

    it 'should not call #set if no data is provided', ->
      sinon.spy Notification.prototype, 'set'

      notification = new Notification

      expect(notification.set.called).to.be.false

      Notification.prototype.set.restore()

  describe '#set', ->
    it 'should accept a string', ->
      notification = new Notification
      notification.set exampleMessages.string

      expect(notification.message).to.equal exampleMessages.string
      expect(notification.message).to.be.a 'string'

    it 'should accept an object', ->
      notification = new Notification
      notification.set exampleMessages.object

      expect(notification.message).to.equal JSON.stringify exampleMessages.object
      expect(notification.message).to.be.a 'string'

    it 'should accept an array', ->
      notification = new Notification
      notification.set exampleMessages.array

      expect(notification.message).to.equal JSON.stringify exampleMessages.array
      expect(notification.message).to.be.a 'string'

  describe '#get', ->
    it 'should return a string when set to a string', ->
      notification = new Notification exampleMessages.string

      expect(notification.get()).to.equal exampleMessages.string

    it 'should return an object when set to an object', ->
      notification = new Notification exampleMessages.object

      expect(notification.get()).to.deep.equal exampleMessages.object

    it 'should return an array when set to an array', ->
      notification = new Notification exampleMessages.array

      expect(notification.get()).to.deep.equal exampleMessages.array

  describe '#send', ->
    it 'should create a pushing socket', ->
      notification = new Notification exampleMessages.string

      sinon.spy zmq, 'socket'

      notification.send()

      expect(zmq.socket.calledOnce).to.be.true

      firstArgument = zmq.socket.firstCall.args[0]

      expect(firstArgument).to.equal 'push'

      zmq.socket.restore()
