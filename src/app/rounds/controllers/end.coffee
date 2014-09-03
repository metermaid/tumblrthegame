rounds = angular.module 'tumblrGame.rounds'

class EndCtrl
  @$inject: ['$scope', 'RoundsRes', 'gameStorage', '$state', '$stateParams', 'hotkeys']

  constructor: ($scope, RoundsRes, gameStorage, $state, $stateParams, hotkeys) ->
    $scope.round = gameStorage.get('current_round')

    if ($stateParams.win == "true")
      $scope.message = "Correct! Now reblog some posts!"
    else
      $scope.message = "Out of time! The answer was \"#{$stateParams.tag}\""

    $scope.posts = []
    
    RoundsRes.jsonp_query tag: $stateParams.tag, before: $stateParams.before, (response) ->
      for post in response.response
        if post.type is "photo"
          $scope.posts.push post
          break if $scope.posts.length >= 6

    $scope.play = ->
      $state.transitionTo "select"

    hotkeys.bindTo($scope).add
      combo: "space"
      description: "Next Stage"
      callback: $scope.play

rounds.controller 'EndCtrl', EndCtrl
