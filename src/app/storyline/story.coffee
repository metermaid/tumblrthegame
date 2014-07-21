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
          className: "story #{$scope.storyline[0].type}"
          plain: true
          scope: $scope
          showClose: false
    $scope.closeAll = ->
      ngDialog.close()

storyline.controller 'StoryCtrl', StoryCtrl

class CutScene
  constructor: (@stage, @screens) ->

class Screen
  constructor: (@style, @dialogs, @options) ->
  add_dialog: (@dialog) ->
    @content.push @dialog

class Dialog
  constructor: (@type, @content, @options) ->

storyline.service "StoryService", ->

  check_points = {
    "1_start": new CutScene("round_start", [
      new Screen("modal", [
        new Dialog("text", "You're nervous as you boot up the test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")
        ])
      ]),
    "1_end": new CutScene("round_end", [
      new Screen("modal", [
        new Dialog("text", "You sigh with relief as you successfully complete your first level. You've taken the first step towards Earth.")
        ])
      ])
  }
  random_chapters = {
    "start": [
      [new StoryScreen("modal", "round_start", "Your mentor offers you words of encouragement: \"Even if you fail the test, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.\" You do not find this encouraging.")],
      [new StoryScreen("modal", "round_start", "You think your mentor is acting especially awkward around you. You suspect that they have read your smutty fanfics.")]
    ],
    "end": [
      [new StoryScreen("modal", "round_end", "One more level down! You did it!", {gif: true})],
      [new StoryScreen("modal", "round_end", "After your victory, your best friend sends you a message."),
      new StoryScreen("modal", "round_end", "You're not sure how to feel about this gif.", {gif: true})],

    ]
  }
  service = {
    get_story: (round, stage) ->
      if "#{round}_#{stage}" of check_points
        chapter = check_points["#{round}_#{stage}"]
      else
        all_chapters = random_chapters[stage]
        chapter = all_chapters[Math.floor(Math.random() * all_chapters.length)]
      
      return chapter
  }
  service