rounds = angular.module 'tumblrGame.rounds'

class HeaderCtrl
  @$inject: ['$scope', 'gameStorage', '$state', '$stateParams']

  constructor: ($scope, gameStorage, $state, $stateParams) ->
    $scope.round = if ($state.current.name == 'end' && $stateParams.win == "true") then gameStorage.get('current_round') - 1 else gameStorage.get('current_round')
    $scope.score = gameStorage.get('score')
    $scope.lives = gameStorage.get('lives')


rounds.controller 'HeaderCtrl', HeaderCtrl
