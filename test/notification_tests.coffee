{Notification} = require '../src/notification'
{expect} = require 'chai'

msgpack = require 'msgpack'
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
    testSet = (message) ->
      notification = new Notification
      notification.set message

      expect(notification.message).to.deep.equal msgpack.pack message

    it 'should accept a string', ->
      testSet exampleMessages.string

    it 'should accept an object', ->
      testSet exampleMessages.object

    it 'should accept an array', ->
      testSet exampleMessages.array

  describe '#get', ->
    testGet = (message) ->
      notification = new Notification message
      expect(notification.get()).to.deep.equal message

    it 'should return a string when set to a string', ->
      testGet exampleMessages.string

    it 'should return an object when set to an object', ->
      testGet exampleMessages.object

    it 'should return an array when set to an array', ->
      testGet exampleMessages.array

  describe '#send', ->
    it 'should send messages using ØMQ', sinon.test ->
      connect = @spy()
      send = @spy()

      @mock(zmq).expects('socket').withArgs('push').once().returns
        connect: connect
        send: send

      notification = new Notification exampleMessages.string
      notification.send()

      expect(connect.calledOnce).to.be.true
      expect(connect.calledBefore send).to.be.true
      expect(connect.firstCall.args.length).to.equal 1

      expect(send.calledOnce).to.be.true
      expect(send.firstCall.args[0]).to.equal notification.message
      expect(send.firstCall.args.length).to.equal 1
