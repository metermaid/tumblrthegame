rounds = angular.module 'tumblrGame.rounds'

class HeaderCtrl
  @$inject: ['$scope', 'gameStorage', '$state']

  constructor: ($scope, gameStorage, $state) ->
    $scope.round = gameStorage.get('current_round')
    $scope.score = gameStorage.get('score')
    $scope.end = ($state.current.name == 'end')


rounds.controller 'HeaderCtrl', HeaderCtrl
