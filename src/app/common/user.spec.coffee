# CoffeeScript
describe 'Service: gameStorage', ->
  gameStorage = null

  # Use to inject the code under test
  _inject = ->
    inject (_gameStorage_) ->
      gameStorage = _gameStorage_
      gameStorage.put('current_round', '1')
      gameStorage.put('score', '0')
      gameStorage.put('lives', '5')

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
      expect(!!gameStorage).toBe true

    it 'get score should return expected value', ->
      result = gameStorage.get('score')
      expect(result).toEqual('0')

    it 'put score should update the score', ->
      gameStorage.put('score', '5')
      result = gameStorage.get('score')
      expect(result).toEqual('5')

    it 'increment score should update the score', ->
      gameStorage.increment('score', '5')
      result = gameStorage.get('score')
      expect(result).toEqual('5')