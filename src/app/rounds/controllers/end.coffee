rounds = angular.module 'tumblrGame.rounds'

class EndCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache', 'RoundsRes', 'StoryService', 'gameStorage', '$filter', '$state', '$stateParams']

  constructor: ($scope, ngDialog, $templateCache, RoundsRes, StoryService, gameStorage, $filter, $state, $stateParams) ->
    $scope.round = gameStorage.get('current_round')

    RoundsRes.jsonp_query tag: 'reaction-gif', before:$stateParams.before, (response) ->
      yay_gifs = $filter('filter')(response.response, { type : 'photo' })
      $scope.gif = yay_gifs[0].photos[0].original_size.url

    RoundsRes.jsonp_query tag: $stateParams.tag, before: $stateParams.before, (response) ->
      $scope.posts = response.response

    $scope.storyline = StoryService.get_story(($scope.round - 1), 'end')

    ngDialog.open
      template: $templateCache.get('storyline/story.tpl.html')
      controller: "StoryCtrl"
      plain: true
      scope: $scope
      showClose: false

    $scope.play = ->
      $state.transitionTo "select"

rounds.controller 'EndCtrl', EndCtrl