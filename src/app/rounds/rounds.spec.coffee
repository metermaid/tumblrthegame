describe 'game rounds', ->

	scope = undefined
	httpBackend = undefined
	beforeEach module("tumblrGame", ($provide) ->
		$provide.value "TagsService",
	   	random_tag: ->
	      	'lotr'
	   $provide.value "RandomDateService",
	   	fromPastMonths: ->
	      	'1391212800000'
		return
	)

	# create the custom mocks on the root scope
	beforeEach angular.mock.inject(($rootScope, _$httpBackend_, $state) ->
		scope = $rootScope.$new()
		scope.httpBackend = _$httpBackend_
		scope.$state = $state
	)

	afterEach ->
		scope.httpBackend.verifyNoOutstandingExpectation()
		scope.httpBackend.verifyNoOutstandingRequest()

	describe "Rounds controller", ->

		beforeEach angular.mock.inject(($controller) ->
			$controller "RoundsCtrl",
			  $scope: scope
			  $state: scope.$state

			scope.httpBackend.expectJSONP("http://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=lotr&before=1391212800000&callback=JSON_CALLBACK").respond {
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
			        }
			      ]
			      original_size:
			        width: 723
			        height: 754
			        url: "https://i.imgur.com/n87W4yl.jpg"
			    ]
			  ]
			}
			scope.$digest()
			scope.httpBackend.flush()
		)

		# tests start here
		describe "Initial render", ->
			it "has one post", ->
				expect(scope.posts.length).toEqual 1
			it "has an empty guess", ->
				expect(scope.guess.length).toEqual 0
			it "is not yet correct", ->
				expect(scope.correct).toEqual false

		describe "Guess has been entered", ->
			it "updates correct variable when a guess is correct", ->
				scope.guess = "#lotr"
				scope.$apply()
				expect(scope.correct).toEqual true
			it "refreshes on a correct guess", ->
				spyOn(scope.$state, "go").andCallThrough()
				scope.guess = "#lotr"
				expect(scope.$state.go).toHaveBeenCalled
			it "does not refresh on an incorrect guess", ->
				spyOn(scope.$state, "go").andCallThrough()
				scope.guess = "#fart"
				expect(scope.$state.go).not.toHaveBeenCalled