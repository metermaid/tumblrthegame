rounds = angular.module 'tumblrGame.rounds'

class EndCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache', 'RoundsRes', 'StoryService', 'gameStorage', '$filter', '$state', '$stateParams', 'hotkeys']

  constructor: ($scope, ngDialog, $templateCache, RoundsRes, StoryService, gameStorage, $filter, $state, $stateParams, hotkeys) ->
    $scope.round = gameStorage.get('current_round')

    console.log("PARM: " + $stateParams.win)

    if ($stateParams.win == "true")
      $scope.message = "Correct! You win!"
      $scope.storyline = StoryService.get_story(($scope.round - 1), 'win')
    else
      $scope.message = "Out of time! The answer was \"#{$stateParams.tag}\""
      $scope.storyline = StoryService.get_story(($scope.round - 1), 'loss')

    RoundsRes.jsonp_query tag: 'reaction-gif', before:$stateParams.before, (response) ->
      yay_gifs = $filter('filter')(response.response, { type : 'photo' })
      $scope.gif = yay_gifs[0].photos[0].original_size.url

    $scope.posts = []
    
    RoundsRes.jsonp_query tag: $stateParams.tag, before: $stateParams.before, (response) ->
      for post in response.response
        if post.type is "photo"
          $scope.posts.push post
          break if $scope.posts.length >= 6



    ngDialog.open
      template: $templateCache.get('storyline/story.tpl.html')
      controller: "StoryCtrl"
      className: "story #{$scope.storyline[0].type}"
      plain: true
      scope: $scope
      showClose: false

    $scope.play = ->
      $state.transitionTo "select"

    hotkeys.bindTo($scope).add
      combo: "enter"
      description: "Next Stage"
      callback: $scope.play

rounds.controller 'EndCtrl', EndCtrl
