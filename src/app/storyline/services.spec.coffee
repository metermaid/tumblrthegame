# CoffeeScript
describe 'Service: StoryService', ->
  StoryService = null

  # Use to inject the code under test
  _inject = ->
    inject (_StoryService_) ->
      StoryService = _StoryService_
      StoryService.random_chapters = {"start": ["dsd"]}

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
      expect(!!StoryService).toBe true

    it 'get_story should return a specified checkpoint cutscene', ->
      result = StoryService.get_story('12', 'start')
      expect(result).toEqual([new Dialog("r u still not at 250 looool", "message B", "becky")])

    it 'get_story should return a random checkpoint cutscene', ->
      result = StoryService.get_story('11', 'start')
