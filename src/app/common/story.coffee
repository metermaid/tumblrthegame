story = angular.module "common.story", []

class StoryScreen
  constructor: (@type, @stage, @text) ->
  display_story: ->
    #if @type == "text"
    html = "<div class=\"storyline\">#{@text}</div>"

    if @stage == "round_start"
      html = html + "<p><a ng-click=\"play()\" class=\"button start\"><i class=\"icon-play\"></i>Start the Game</a></p>"
    else if  @stage == "round_end"
      html = html + "<p><a ng-click=\"play()\" class=\"button start\"><i class=\"icon-play\"></i>Next Round</a></p>"
    else
      html = html + "no seriously"

    html

story.service "StoryService", ->

  check_points = {
    "1_start": [new StoryScreen("text", "round_start", "You're nervous as you boot up the test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")]
  }
  random_chapters = {
    "start": [
      [new StoryScreen("text", "round_start", "Your mentor offers you words of encouragement: \"Even if you fail the test, maybe you can just be a very stupid human.\" You do not find this encouraging.")]
    ],
    "end": [
      [new StoryScreen("text", "round_end", "One level down! You did it!")]
    ]
  }
  service = {
    get_story: (round, stage) ->
      if "#{round}_#{stage}" in check_points
        chapter = check_points["#{round}_#{stage}"]
      else
        all_chapters = random_chapters[stage]
        chapter = all_chapters[Math.floor(Math.random() * all_chapters.length)]
      
      return chapter.map (screen) -> screen.display_story()
  }
  service