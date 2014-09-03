# CoffeeScript
describe 'Service: TagsService', ->
  TagsService = null

  # Use to provide any mocks needed
  _provide = (callback) ->
    # Execute callback with $provide
    module ($provide) ->
      callback $provide
      # Make sure CoffeeScript doesn't return anything
      null

  # Use to inject the code under test
  _inject = ->
    inject (_TagsService_) ->
      TagsService = _TagsService_
    inject (allTags) ->
      tags = allTags


  # Call this before each test, except where you are testing for errors
  _setup = ->
    # Mock any expected data
    _provide (provide) ->
      provide.constant 'allTags', {'dorks': ['sherlock']}

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
      expect(!!TagsService).toBe true

    it 'random_categories should return an array of category names', ->
      result = TagsService.random_categories(1)
      expect(result).toEqual(['dorks'])

    it 'random_tag_index should return the index of a tag within that category', ->
      result = TagsService.random_tag_index('dorks')
      expect(result).toEqual(0)

    it 'tag should return that tag given an index and a category', ->
      result = TagsService.tag('dorks', 0)
      expect(result).toEqual('sherlock')

    it 'random_tag should return a tag within that category', ->
      result = TagsService.random_tag('dorks')
      expect(result).toEqual('sherlock')
