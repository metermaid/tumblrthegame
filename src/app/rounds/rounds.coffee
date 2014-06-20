
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

rounds.service "TagsService", ->
  random_tag: (type) ->
    all_tags = {
      'series': ["adventure time", "supernatural", "doctor who", "lotr", "harry potter"],
      'characters': ["hannibal lecter", "mako mori", "katniss everdeen"]
    }
    tags = all_tags[type]
    return tags[Math.floor(Math.random() * tags.length)]

rounds.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("http://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK", {},
      jsonp_query:
        tag: @tag
        method: "JSONP"
    )
]

class RoundsCtrl
  @$inject = ['$scope', 'TagsService', 'RoundsRes', '$state']

  constructor: ($scope, TagsService, RoundsRes, $state) ->
    $scope.type = 'series'
    tag = TagsService.random_tag($scope.type)
    $scope.correct = false
    $scope.guess = ""
    tag_regex = new RegExp('^#'+tag+'$', "i")
    RoundsRes.jsonp_query tag: "adventure time", before: (Date.now() - (Math.floor(Math.random() * 2678400 * 12))) / 1000, (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = tag_regex.test(guess)

    $scope.$watch "correct", (correct) ->
      $state.go($state.$current, null, { reload: true }) if correct


rounds.controller 'RoundsCtrl', RoundsCtrl
