modules = [
  'ngDialog'#,
  #'rounds.services'
]

storyline = angular.module 'tumblrGame.storyline', modules

class StoryCtrl
  @$inject: ['$scope', 'ngDialog', '$templateCache']

  constructor: ($scope, ngDialog, $templateCache) ->

    [$scope.current_dialog, $scope.storyline...] = $scope.storyline

    $scope.next = ->
      ngDialog.close
      if $scope.storyline.length > 0
        ngDialog.open
          template: $templateCache.get('storyline/story.tpl.html')
          controller: "StoryCtrl"
          className: "story #{$scope.storyline.dialogs[0].type}"
          plain: true
          scope: $scope
          showClose: false
    $scope.closeAll = ->
      ngDialog.close()

storyline.controller 'StoryCtrl', StoryCtrl

class CutScene
  constructor: (@stage, @dialogs) ->

class Dialog
  constructor: (@type, @content, @button) ->

storyline.service "StoryService", (RandomDateService, RoundsRes, $filter) ->
  gif = ""
  '''
  before_date = RandomDateService.fromPastMonths(12) # past year
  RoundsRes.jsonp_query tag: 'reaction-gif', before: before_date, (response) ->
    gifs = $filter('filter')(response.response, { type : 'photo' })
    gif = gifs[0].photos[0].original_size.url
    '''

  check_points = {
    "1_start": new CutScene("start", [
        new Dialog("modal", "You're nervous as you boot up the test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")
      ]),
    "1_win": new CutScene("win", [
        new Dialog("modal", "You sigh with relief as you successfully complete your first level. You've taken the first step towards Earth.")
      ])
  }
  random_chapters = {
    "start": [
      new CutScene("start", [
        new Dialog("modal", "Your mentor offers you words of encouragement: \"Even if you fail the test, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.\" You do not find this encouraging.")
      ]),
      new CutScene("start", [
        new Dialog("modal", "You think your mentor is acting especially awkward around you. You suspect that they have read your smutty fanfics.")
      ])
    ],
    "end": [
      new CutScene("win", [
        new Dialog("modal", "One more level down! You did it!")
      ]),
      new CutScene("win", [
        new Dialog("modal", "After your victory, your best friend sends you a message."),
        new Dialog("gif", gif),
        new Dialog("modal", "You're not sure how to feel about that.")
      ])
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
