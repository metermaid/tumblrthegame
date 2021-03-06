'''
describe 'Directive: shaker', ->
  element = scope = compile = defaultData = null
  validTemplate = '<input shaker></input>'

  createDirective = (data, template) ->
    # Setup scope state
    scope.data = data or defaultData

    # Create directive
    elm = compile(template or validTemplate) scope

    # Trigger watchers
    scope.$apply()

    # Return
    elm

  beforeEach ->
    # Load the directive's module
    module 'tumblrGame'

    # Reset data each time
    defaultData = []

    # Provide any mocks needed
    module ($provide) ->
      #$provide.value 'Name', new MockName()
      # Make sure CoffeeScript doesn't return anything
      null

    # Inject in angular constructs otherwise,
    #  you would need to inject these into each test
    inject ($rootScope, $compile, $state) ->
      scope = $rootScope.$new()
      compile = $compile

  describe 'when created', ->
    # Add specs

  describe 'when the model changes', ->
    # Add specs

  describe 'when destroyed', ->
    # Add specs
'''