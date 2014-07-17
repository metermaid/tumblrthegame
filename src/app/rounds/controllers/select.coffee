rounds = angular.module 'tumblrGame.rounds'

class SelectCtrl
   @$inject: ['$scope', 'TagsService', 'gameStorage', '$state', 'hotkeys']

   constructor: ($scope, TagsService, gameStorage, $state, hotkeys) ->
      num_categories = 4
      $scope.round = gameStorage.get('current_round')
      $scope.categories = TagsService.random_categories(num_categories)

      $scope.play = (category) ->
         for i in [0..num_categories] by 1 # todo: remove all these magic numbers
            hotkeys.del("ctrl+#{i+1}")
         $state.transitionTo "round", {type: category}

      makeHotKey = (category, index) ->
         hotkeys.add
            combo: "ctrl+#{index+1}"
            description: "Go to #{category} Stage"
            callback: ->
               $scope.play category

      for category, index in $scope.categories
         makeHotKey(category, index)

rounds.controller 'SelectCtrl', SelectCtrl