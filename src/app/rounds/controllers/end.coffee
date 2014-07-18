rounds = angular.module 'tumblrGame.rounds'

class EndCtrl
  @$inject: ['$scope', 'RoundsRes', 'gameStorage', '$filter', '$state', '$stateParams', 'hotkeys']

  constructor: ($scope, RoundsRes, gameStorage, $filter, $state, $stateParams, hotkeys) ->
    $scope.round = gameStorage.get('current_round')

    console.log("PARM: " + $stateParams.win)

    if ($stateParams.win == "true")
      $scope.winMessage = "Correct! You win!"
    else
      $scope.winMessage = "Out of time! You didn't win."

    RoundsRes.jsonp_query tag: 'reaction-gif', before:$stateParams.before, (response) ->
      yay_gifs = $filter('filter')(response.response, { type : 'photo' })
      $scope.gif = yay_gifs[0].photos[0].original_size.url

    RoundsRes.jsonp_query tag: $stateParams.tag, before: $stateParams.before, (response) ->
      $scope.posts = response.response

    $scope.play = ->
      $state.transitionTo "select"

    hotkeys.bindTo($scope).add
      combo: "enter"
      description: "Next Stage"
      callback: $scope.play

rounds.controller 'EndCtrl', EndCtrl
