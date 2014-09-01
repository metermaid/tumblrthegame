describe 'story', ->

   scope = undefined
   httpBackend = undefined
   storage = undefined


   beforeEach module("tumblrGame", ($provide) ->
      store = {
         "current_round": 1,
         "score": 0,
         "lives": 3
      }

      $provide.constant "gameStorage",
         get: (storageID) ->
            store[storageID]
         increment: (storageID, n) ->
            store[storageID] = store[storageID] + n
         put: (storageID, n) ->
            store[storageID] = n

      return
   )

   # create the custom mocks on the root scope
   beforeEach angular.mock.inject(($rootScope, _$httpBackend_, _$timeout_, $state) ->
      scope = $rootScope.$new()
      scope.httpBackend = _$httpBackend_
      scope.$state = $state
      timeout = _$timeout_
   )

   beforeEach inject((gameStorage) ->
     storage = gameStorage
   )

   afterEach ->
      scope.httpBackend.verifyNoOutstandingExpectation()
      scope.httpBackend.verifyNoOutstandingRequest()

   describe "Home controller", ->

      beforeEach angular.mock.inject(($controller) ->

         $controller "HomeCtrl",
           $scope: scope
           $state: scope.$state
           gameStorage: storage

      )

      # tests start here
      describe "Play Button", ->
         it "resets the store if there are no lives", ->
            storage.put('lives',0)
            expect(storage.get('lives')).toEqual 0
            scope.play()
            expect(storage.get('lives')).toEqual 5
            expect(storage.get('score')).toEqual 0
            expect(storage.get('current_round')).toEqual 1
         it "does not resets the store if there are lives", ->
            spyOn(storage, "get").andCallThrough()
            spyOn(storage, "put").andCallThrough()
            scope.play()
            expect(storage.get).toHaveBeenCalledWith 'lives'
            expect(storage.get('lives')).toEqual 3
            expect(storage.put).not.toHaveBeenCalled


         it "transitions to select", ->
            spyOn(scope.$state, "transitionTo").andCallThrough()
            scope.play()
            expect(scope.$state.transitionTo).toHaveBeenCalledWith "select"