rounds = angular.module 'tumblrGame.rounds'

class SelectCtrl
   @$inject: ['$scope', 'TagsService', 'gameStorage', '$state', 'hotkeys']

   constructor: ($scope, TagsService, gameStorage, $state, hotkeys) ->
      $scope.round = gameStorage.get('current_round')
      $scope.categories = TagsService.random_categories(4)

      $scope.play = (category) ->
         $state.transitionTo "round", {type: category}

      makeHotKey = (category, index) ->
         hotkeys.bindTo($scope).add
            combo: "ctrl+#{index+1}"
            description: "Go to #{category} Stage"
            callback: ->
               $scope.play category

      for category, index in $scope.categories
         makeHotKey(category, index)

rounds.controller 'SelectCtrl', SelectCtrl