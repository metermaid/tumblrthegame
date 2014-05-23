
modules = [
  'ui.router',
  'ngResource'
]

rounds = angular.module 'tumblrGame.rounds', modules

roundsConfig = ($stateProvider) ->
  $stateProvider.state "rounds",
    url: "/rounds"
    views:
      main:
        controller: "RoundsCtrl"
        templateUrl: "rounds/index.tpl.html"

    data:
      pageTitle: "Rounds"

roundsConfig.$inject = ['$stateProvider']
rounds.config roundsConfig

rounds.directive "tagChecker", ->

rounds.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("http://api.tumblr.com/v2/tagged?api_key=PLACEHOLDER&tag=:tag&callback=JSON_CALLBACK", {},
      jsonp_query:
        tag: @tag
        method: "JSONP"
    )
]

class RoundsCtrl
  @$inject = ['$scope', 'RoundsRes']

  constructor: ($scope, RoundsRes) ->
    $scope.type = 'series'
    all_tags = {
      'series': ["adventure time", "supernatural", "doctor who", "lotr", "harry potter"],
      'characters': ["hannibal lecter", "mako mori", "katniss everdeen"]
    }
    tags = all_tags[$scope.type]
    tag = tags[Math.floor(Math.random() * tags.length)]
    $scope.correct = false
    $scope.guess = ""
    $scope.tag_regex = new RegExp('^#'+tag+'$', "i")
    RoundsRes.jsonp_query tag: tag, (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = guess.match $scope.tag_regex


rounds.controller 'RoundsCtrl', RoundsCtrl
