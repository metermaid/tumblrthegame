# CoffeeScript
describe 'Service: StoryService', ->
  StoryService = null

  # Use to provide any mocks needed
  _provide = (callback) ->
    # Execute callback with $provide
    module ($provide) ->
      callback $provide
      # Make sure CoffeeScript doesn't return anything
      null

  # Use to inject the code under test
  _inject = ->
    inject (_StoryService_) ->
      StoryService = _StoryService_
    inject (random_chapters) ->
      chapters = random_chapters

  # Call this before each test, except where you are testing for errors
  _setup = ->
    # Mock any expected data
    _provide (provide) ->
      provide.constant 'random_chapters', {"start": ["dsd"]}

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
      expect(!!StoryService).toBe true

    it 'get_story should return a specified checkpoint cutscene', ->
      result = StoryService.get_story('12', 'start')
      expect(result).toEqual([new Dialog("r u still not at 250 looool", "message B", "becky")])

    it 'get_story should return a random checkpoint cutscene', ->
      result = StoryService.get_story('11', 'start')
      expect(result).toEqual("dsd")
