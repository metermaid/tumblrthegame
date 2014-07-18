rounds = angular.module 'tumblrGame.rounds'

class RoundCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache', 'TagsService', 'RandomDateService', 'RoundsRes', 'StoryService', 'gameStorage', '$state', '$stateParams', '$timeout']

  constructor: ($scope, ngDialog, $templateCache, TagsService, RandomDateService, RoundsRes, StoryService, gameStorage, $state, $stateParams, $timeout) ->
    $scope.round = gameStorage.get('current_round')
    $scope.type = $stateParams.type || 'series'
    $scope.roundStartTime = Date.now()
    $scope.secondsLeft = 10 # eventually put this in a file that's more more settings-y
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
      className: "story #{$scope.storyline[0].type}"
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
        $scope.stop()
        $state.transitionTo "end", tag: tag.name, before: before_date, win: true

    timeout = null
    $scope.onTimeout = () ->
      $scope.secondsLeft--
      if $scope.secondsLeft >= 1
        timeout = $timeout($scope.onTimeout, 1000)
      else
        $scope.stop()
        $state.transitionTo "end", tag: tag.name, before: before_date, win: false
    timeout = $timeout($scope.onTimeout, 1000)

    $scope.stop = () -> $timeout.cancel(timeout)


rounds.controller 'RoundCtrl', RoundCtrl
