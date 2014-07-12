rounds = angular.module 'tumblrGame.rounds'

class SelectCtrl
  @$inject: ['$scope', 'TagsService', 'gameStorage', '$state']

  constructor: ($scope, TagsService, gameStorage, $state) ->
    $scope.round = gameStorage.get('current_round')
    $scope.categories = TagsService.random_categories(4)

    $scope.play = (category) ->
      $state.transitionTo "round", {type: category}


rounds.controller 'SelectCtrl', SelectCtrl