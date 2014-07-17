rounds = angular.module 'tumblrGame.rounds'

class RoundCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache', 'TagsService', 'RandomDateService', 'RoundsRes', 'StoryService', 'gameStorage', '$state', '$stateParams']

  constructor: ($scope, ngDialog, $templateCache, TagsService, RandomDateService, RoundsRes, StoryService, gameStorage, $state, $stateParams) ->
    $scope.round = gameStorage.get('current_round')
    $scope.type = $stateParams.type || 'series'
    tag = TagsService.random_tag($scope.type)
    $scope.correct = false
    $scope.guess = ""
    tag_regex = new RegExp("^#?" + tag.regex.source + "$", "i")
    before_date = RandomDateService.fromPastMonths(12) # past year
    RoundsRes.jsonp_query tag: tag.name, before: before_date, (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.storyline = StoryService.get_story(($scope.round), 'start')

    ngDialog.open
      template: $templateCache.get('storyline/story.tpl.html')
      controller: "StoryCtrl"
      plain: true
      scope: $scope
      showClose: false

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = guess.search(tag_regex) != -1
      $scope.correct

    $scope.$watch "correct", (correct) ->
      if correct
        gameStorage.increment('current_round', 1)
        $state.transitionTo "end", tag: tag.name, before: before_date


rounds.controller 'RoundCtrl', RoundCtrl
