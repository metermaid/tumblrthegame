modules = [
  'ui.router',

  'common.directives',
  'common.tags',
  'common.user_storage',

  'rounds.services',
  'cfp.hotkeys',

  'story.services'
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
      imagePreloader.preloadImages(images)

    $scope.dialogID = 0

    $scope.next = ->
      if $scope.dialogID < ($scope.storyline.length - 1)
        $scope.dialogID = $scope.dialogID + 1
      else
        $scope.start()

    $scope.start = ->
      $state.transitionTo "round", category: $stateParams.category, index: tag_index, before: before_date # can't pass objects yet with ui-router, so work around

    hotkeys.bindTo($scope).add
      combo: "space"
      description: "Next"
      callback: $scope.next

    hotkeys.bindTo($scope).add
      combo: "enter"
      description: "Skip"
      callback: $scope.start

storyline.controller 'StoryCtrl', StoryCtrl