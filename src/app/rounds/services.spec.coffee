# CoffeeScript
describe 'Service: RandomDateService', ->
  RandomDateService = null

  # Use to inject the code under test
  _inject = ->
    inject (_RandomDateService_) ->
      RandomDateService = _RandomDateService_

  # Call this before each test, except where you are testing for errors
  _setup = ->
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
      expect(!!RandomDateService).toBe true

    it 'fromPastMonths should return a random date', ->
      result = RandomDateService.fromPastMonths(0)
      expect(result).toEqual(Date.now()/1000)