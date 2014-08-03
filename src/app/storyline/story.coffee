modules = [
  'ui.router',

  'common.directives',
  'common.tags',
  'common.user_storage',

  'rounds.services',
  'cfp.hotkeys'

  'cfp.hotkeys',
  'rounds.services'
]

storyline = angular.module 'tumblrGame.storyline', modules

storylineConfig = ($stateProvider) ->
  $stateProvider.state "story",
    params: ["type", "category"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/views/header.tpl.html"
      main:
        controller: "StoryCtrl"
        templateUrl: "storyline/story.tpl.html"
    data:
      pageTitle: "Round Start"


storylineConfig.$inject = ['$stateProvider']
storyline.config storylineConfig

class StoryCtrl
  @$inject: ['$scope', 'TagsService', 'RandomDateService', 'StoryService', 'gameStorage', 'RoundsRes', '$state', '$stateParams', 'hotkeys', 'imagePreloader']

  constructor: ($scope, TagsService, RandomDateService, StoryService, gameStorage, RoundsRes, $state, $stateParams, hotkeys, imagePreloader) ->
    $scope.round = gameStorage.get('current_round')
    $scope.storyline = StoryService.get_story(($scope.round), $stateParams.type)

    $scope.category = $stateParams.category || 'tv series'
    tag_index = TagsService.random_tag_index($scope.category)
    tag = TagsService.tag($scope.category, tag_index)
    before_date = RandomDateService.fromPastMonths(12) # past year

    $scope.posts = []

    RoundsRes.jsonp_query tag: tag.name, before: before_date, (response) ->
      $scope.message = response.meta

      for post in response.response
        if post.type is "photo"
          $scope.posts.push post
          break if $scope.posts.length >= 6

      images = $scope.posts.map (post) -> post.photos[0].alt_sizes[1].url

      # Preload the images; then, update display when returned.
      imagePreloader.preloadImages(images).then ( (images) ->
        # Loading was successful.
        $scope.isLoading = false
        $scope.isSuccessful = true
        console.info "Preload Successful"
      ), ( (image) ->
        # Loading failed on at least one image, but that's ok
        $scope.isLoading = false
        $scope.isSuccessful = false
        console.error "Image Failed", image
        console.info "Preload Failure"
      ), (event) ->
        $scope.percentLoaded = event.percent
        console.info "Percent loaded:", event.percent

    $scope.dialogID = 0

    $scope.next = ->
      if $scope.dialogID < ($scope.storyline.length - 1)
        $scope.dialogID = $scope.dialogID + 1
      else
        $state.transitionTo "round", category: $stateParams.category, index: tag_index, before: before_date # can't pass objects yet with ui-router, so work around

    hotkeys.bindTo($scope).add
      combo: "enter"
      description: "Next"
      callback: $scope.next

storyline.controller 'StoryCtrl', StoryCtrl

class Dialog
  constructor: (@content, @type = "modal", @speaker, @button) ->

storyline.service "StoryService", ->

  check_points = {
    "1_start": [
        new Dialog("You're a bit confused by the premise of this test, so you message your mentor."),
        new Dialog("Kcklqkla, if this test is pulling the latest posts from Tumblr, what guarantee is there that the posts would make sense in the context of the test? Humans sometimes tag things incorrectly.", "message U", "you"),
        new Dialog("Oh, there's no guarantee. Sometimes it's gibberish. Sometimes it's human pornography. Have fun.", "message K", "kcklqkla"),
        new Dialog("That was discouraging. The High Council is a cruel organization.")
      ]
  }
  random_chapters = {
    "start": [
      [
        new Dialog("Your mentor offers you words of encouragement: \"Even if you fail your studies, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.\" You do not find this encouraging.")
      ],
      [
        new Dialog("You think your mentor, Kcklqkla, is acting especially awkward around you. You suspect that they have read your smutty fanfics.")
      ],
      [
        new Dialog("You feel extremely nervous about this test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")
      ]
    ]
  }
  service = {
    get_story: (round, stage) ->
      if "#{round}_#{stage}" of check_points
        chapter = check_points["#{round}_#{stage}"]
      else
        all_chapters = random_chapters[stage]
        chapter = all_chapters[Math.floor(Math.random() * all_chapters.length)]
      
      return chapter
  }
  service
