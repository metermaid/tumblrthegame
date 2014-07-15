modules = [
  'ngDialog',
  'ngResource'
]

storyline = angular.module 'tumblrGame.storyline', modules

class StoryCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache']

  constructor: ($scope, ngDialog, $templateCache) ->

    [$scope.current_story, $scope.storyline...] = $scope.storyline

    $scope.next = ->
      ngDialog.close
      if $scope.storyline.length > 0
        ngDialog.open
          template: $templateCache.get('storyline/story.tpl.html')
          controller: "StoryCtrl"
          plain: true
          scope: $scope

storyline.controller 'StoryCtrl', StoryCtrl


class StoryScreen
  constructor: (@type, @stage, @text) ->

storyline.service "StoryService", ->

  check_points = {
    "1_start": [new StoryScreen("text", "round_start", "You're nervous as you boot up the test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")]
  }
  random_chapters = {
    "start": [
      [new StoryScreen("text", "round_start", "Your mentor offers you words of encouragement: \"Even if you fail the test, maybe you can just be a very stupid human.\" You do not find this encouraging.")]
    ],
    "end": [
      [new StoryScreen("text", "round_end", "One level down! You did it!"),
      new StoryScreen("text", "round_end", "test for variety"),
      new StoryScreen("text", "round_end", "whats new for variety")]
    ]
  }
  service = {
    get_story: (round, stage) ->
      if "#{round}_#{stage}" in check_points
        chapter = check_points["#{round}_#{stage}"]
      else
        all_chapters = random_chapters[stage]
        chapter = all_chapters[Math.floor(Math.random() * all_chapters.length)]
      
      return chapter
  }
  service