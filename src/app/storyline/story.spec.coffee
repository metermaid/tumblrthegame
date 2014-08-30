describe 'story', ->

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

	describe "Story controller", ->

		beforeEach angular.mock.inject(($controller) ->

			params = { tag: 'lotr', before: '1391212800000' }

			$controller "StoryCtrl",
			  $scope: scope
			  $state: scope.$state
			  gameStorage: storage
			  $stateParams: params

			scope.httpBackend.expectJSONP("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=reaction-gif&before=1391212800000&callback=JSON_CALLBACK").respond lotrPosts
			scope.httpBackend.expectJSONP("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=lotr&before=1391212800000&callback=JSON_CALLBACK").respond lotrPosts

			scope.$digest()
			scope.httpBackend.flush()
		)

		# tests start here
		describe "Initial render", ->
			it "reports no rounds won", ->
				expect(scope.round).toEqual 1

			it "has one post", ->
				expect(scope.posts.length).toEqual 1

			it "has one reaction gif", ->
				expect(scope.gif).toEqual lotrPosts.response[0].photos[0].original_size.url

