rounds = angular.module 'tumblrGame.rounds'

class LoseCtrl
   @$inject: ['$scope', 'gameStorage', '$state', 'hotkeys']

   constructor: ($scope, gameStorage, $state, hotkeys) ->
      $scope.round = gameStorage.get('current_round')
      $scope.score = gameStorage.get('score')

      $scope.returnToHome = () ->
        $state.transitionTo "home"

      $scope.shareScore = () ->
        # fill me in later

      hotkeys.bindTo($scope).add
        combo: "enter"
        description: "Return to Home"
        callback: $scope.returnToHome

rounds.controller 'LoseCtrl', LoseCtrl
