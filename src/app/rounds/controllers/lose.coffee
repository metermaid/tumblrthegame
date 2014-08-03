rounds = angular.module 'tumblrGame.rounds'

class LoseCtrl
   @$inject: ['$scope', 'TagsService', 'gameStorage', '$state', 'hotkeys']

   constructor: ($scope, TagsService, gameStorage, $state, hotkeys) ->
      num_categories = 4
      $scope.round = gameStorage.get('current_round')
      $scope.score = gameStorage.get('score')
      $scope.categories = TagsService.random_categories(num_categories)

      $scope.returnToHome = () ->
        $state.transitionTo "home"

      $scope.shareScore = () ->
        # fill me in later

      hotkeys.bindTo($scope).add
        combo: "enter"
        description: "Return to Home"
        callback: $scope.returnToHome

rounds.controller 'LoseCtrl', LoseCtrl
