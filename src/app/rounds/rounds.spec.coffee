describe 'game rounds', ->

	scope = undefined
	timeout = undefined
	httpBackend = undefined
	storage = undefined

	lotrPosts = {
		meta:
			status: 200
			msg: "OK"

		response: [
			blog_name: "demo"
			id: 12
			post_url: "http://demo.tumblr.com/post/1/fake"
			slug: "fake"
			type: "photo"
			date: "2014-05-31 06:04:08 GMT"
			timestamp: 1401516248
			state: "published"
			format: "html"
			reblog_key: "fake"
			tags: [
				"lotr"
				"tolkien"
			]
			short_url: "http://tmblr.co/ZQ7KZy1HNhOji"
			highlighted: []
			note_count: 0
			caption: "hobbits"
			link_url: "http://www.lordoftherings.net/"
			image_permalink: "https://i.imgur.com/n87W4yl.jpg"
			photos: [
				caption: ""
				alt_sizes: [
					{
						width: 75
						height: 75
						url: "https://i.imgur.com/n87W4yl.jpg"
					},
					{
						width: 75
						height: 75
						url: "https://i.imgur.com/n87W4yl.jpg"
					}
				]
				original_size:
					width: 723
					height: 754
					url: "https://i.imgur.com/n87W4yl.jpg"
				]
			]
	}

	beforeEach module("tumblrGame", ($provide) ->
		$provide.value "TagsService",
			random_tag_index: ->
				0
			random_tag: ->
		   	{"name" : "lotr", "regex" : /lotr/}
		   tag: ->
		   	{"name" : "lotr", "regex" : /lotr/}
		   random_categories: ->
		   	['series', 'anime', 'characters', 'dog breeds']
		   check_tag_aliases: (type, tag, guess) ->
		   	guess == 'lotr'
		$provide.value "RandomDateService",
			fromPastMonths: ->
		   	'1391212800000'

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

	describe "Header controller", ->

		beforeEach angular.mock.inject(($controller) ->
			$controller "HeaderCtrl",
			  $scope: scope
			  $state: scope.$state
			  gameStorage: storage
		)

		# tests start here
		describe "Initial render", ->
			it "reports score", ->
				expect(scope.score).toEqual 0
			it "reports lives", ->
				expect(scope.lives).toEqual 3

	describe "Select controller", ->

		beforeEach angular.mock.inject(($controller) ->
			$controller "SelectCtrl",
			  $scope: scope
			  $state: scope.$state
			  gameStorage: storage
		)

		# tests start here
		describe "Initial render", ->
			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

			it "displays four categories", ->
				expect(scope.categories.length).toEqual 4

	describe "Round controller", ->
		params = { category: 'books', tag: {name: 'lotr', regex: /lotr/}, before: '1391212800000' }

		beforeEach angular.mock.inject(($controller, $timeout) ->
			$controller "RoundCtrl",
			  $scope: scope
			  $state: scope.$state
			  gameStorage: storage
			  $stateParams: params

			scope.httpBackend.expectJSONP("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=lotr&before=1391212800000&callback=JSON_CALLBACK").respond lotrPosts

			scope.$digest()
			scope.httpBackend.flush()
		)

		# tests start here
		describe "Initial render", ->
			it "has one post", ->
				expect(scope.posts.length).toEqual 1
			it "has an empty guess", ->
				expect(scope.guess.length).toEqual 0
			it "is has a playing status", ->
				expect(scope.status).toEqual 'playing'
			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

		describe "Guess has been entered", ->
			it "updates status variable when a guess is correct", ->
				scope.updateGuess("#lotr")
				expect(scope.status).toEqual 'won'
			it "does not update status variable when a guess is incorrect", ->
				scope.updateGuess("#fart")
				expect(scope.status).toEqual 'playing'


			it "increments points with appropriate number of points when a guess is correct", ->
				spyOn(storage, "increment").andCallThrough()
				scope.updateGuess("#lotr")
				expect(storage.increment).toHaveBeenCalledWith 'score', 25
			it "does not increment points  when a guess is incorrect", ->
				spyOn(storage, "increment").andCallThrough()
				scope.updateGuess("#fart")
				expect(storage.increment).not.toHaveBeenCalled

			it "redirects to the end state on a correct guess", ->
				spyOn(scope.$state, "transitionTo").andCallThrough()
				scope.updateGuess("#lotr")
				timeout.flush()
				expect(scope.$state.transitionTo).toHaveBeenCalledWith "end", tag : 'lotr', before: '1391212800000', win: true
			it "does not refresh on an incorrect guess", ->
				spyOn(scope.$state, "transitionTo").andCallThrough()
				scope.updateGuess("#fart")
				expect(scope.$state.transitionTo).not.toHaveBeenCalled

			it "increments rounds won on a correct guess", ->
				spyOn(storage, "increment").andCallThrough()
				scope.updateGuess("#lotr")
				expect(storage.increment).toHaveBeenCalledWith 'current_round', 1
			it "does not increment rounds won on an incorrect guess", ->
				spyOn(storage, "increment").andCallThrough()
				scope.updateGuess("#fart")
				expect(storage.increment).not.toHaveBeenCalled


		describe "Timer runs out without a correct guess", ->
			it "decrements lives", ->
				spyOn(storage, "increment").andCallThrough()
				scope.secondsLeft = 1
				scope.onTimeout()
				expect(storage.increment).toHaveBeenCalledWith 'lives', -1
			it "updates status variable", ->
				scope.secondsLeft = 1
				scope.onTimeout()
				expect(scope.status).toEqual 'lost'
			it "redirects to end state if there are lives left", ->
				spyOn(scope.$state, "transitionTo").andCallThrough()
				scope.secondsLeft = 1
				scope.onTimeout()
				timeout.flush()
				expect(scope.$state.transitionTo).toHaveBeenCalledWith "end", tag : 'lotr', before: '1391212800000', win: false
			it "redirects to lose state if there are no lives left", ->
				spyOn(scope.$state, "transitionTo").andCallThrough()
				storage.increment('lives',-2)
				scope.secondsLeft = 1
				scope.onTimeout()
				timeout.flush()
				expect(scope.$state.transitionTo).toHaveBeenCalledWith "lose"



	describe "End controller", ->

		# tests start here
		describe "Initial render of winning state", ->
			beforeEach angular.mock.inject(($controller) ->

				params = { tag: 'lotr', before: '1391212800000', win: 'true' }

				$controller "EndCtrl",
				  $scope: scope
				  $state: scope.$state
				  gameStorage: storage
				  $stateParams: params

				scope.httpBackend.expectJSONP("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=lotr&before=1391212800000&callback=JSON_CALLBACK").respond lotrPosts

				scope.$digest()
				scope.httpBackend.flush()
			)
			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

			it "has one post", ->
				expect(scope.posts.length).toEqual 1

			it "returns a positive message", ->
				expect(scope.message).toEqual "Correct! Now reblog some posts!"

		describe "Initial render of losing state", ->
			beforeEach angular.mock.inject(($controller) ->

				params = { tag: 'lotr', before: '1391212800000', win: 'false' }

				$controller "EndCtrl",
				  $scope: scope
				  $state: scope.$state
				  gameStorage: storage
				  $stateParams: params

				scope.httpBackend.expectJSONP("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=lotr&before=1391212800000&callback=JSON_CALLBACK").respond lotrPosts

				scope.$digest()
				scope.httpBackend.flush()
			)

			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

			it "has one post", ->
				expect(scope.posts.length).toEqual 1

			it "returns a negative message", ->
				expect(scope.message).toEqual "Out of time! The answer was \"lotr\""


	describe "Lose controller", ->

		beforeEach angular.mock.inject(($controller) ->
			$controller "LoseCtrl",
			  $scope: scope
			  $state: scope.$state
			  gameStorage: storage
		)

		# tests start here
		describe "Initial render", ->
			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

			it "reports the score", ->
				expect(scope.score).toEqual 0
