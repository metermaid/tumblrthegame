# CoffeeScript
describe 'Service: preloader', ->
  mySvc = null
'''
  # Use to provide any mocks needed
  _provide = (callback) ->
    # Execute callback with $provide
    module ($provide) ->
      callback $provide
      # Make sure CoffeeScript doesn't return anything
      null

  # Use to inject the code under test
  _inject = ->
    inject (_mySvc_) ->
      mySvc = _mySvc_

  # Call this before each test, except where you are testing for errors
  _setup = ->
    # Mock any expected data
    _provide (provide) ->
      provide.value 'myVal', {}

    # Inject the code under test
    _inject()

  beforeEach ->
    # Load the service's module
    module 'tumblrGame'

  describe 'the service api', ->
    beforeEach ->
      # Inject with all expected values
      _setup()

    it 'should exist', ->
      expect(!!mySvc).toBe true

    # Add specs

  describe 'service errors', ->
 
    it 'should throw an error when required dependency is missing', ->
      # Use an anonymous function to wrap the code that will fail
      wrapper = ->
        # Inject WITHOUT providing required values
        _inject()
      expect(wrapper).toThrow 'mySvc: myVal not provided'
      ###
      Note: you can use Function.bind to avoid an anonymous function wrapper for inject,
      however, you'll need a polyfill for PhantomJS such as: http://goo.gl/XSLOdx
      svc = (mySvc) ->
      expect(inject.bind(null, svc)).toThrow 'mySvc: myVal not provided'
      ###
 '''