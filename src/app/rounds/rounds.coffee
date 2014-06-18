
modules = [
  'ui.router',
  'ngResource'
]

rounds = angular.module 'tumblrGame.rounds', modules

roundsConfig = ($stateProvider) ->
  $stateProvider.state "round",
    params: ["type"]
    views:
      main:
        controller: "RoundCtrl"
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
      'characters': ["hannibal lecter", "mako mori", "katniss everdeen"],
      'anime': ['cowboy bebop', 'space dandy', 'kill la kill', 'attack on titan']
    }
    tags = all_tags[type]
    return tags[Math.floor(Math.random() * tags.length)]

rounds.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("http://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&callback=JSON_CALLBACK", {},
      jsonp_query:
        tag: @tag
        method: "JSONP"
    )
]

class RoundCtrl
  @$inject = ['$scope', 'TagsService', 'RoundsRes', '$state', '$stateParams']

  constructor: ($scope, TagsService, RoundsRes, $state, $stateParams) ->
    $scope.type = $stateParams.type || 'series'
    tag = TagsService.random_tag($scope.type)
    $scope.correct = false
    $scope.guess = ""
    tag_regex = new RegExp('^#'+tag+'$', "i")
    RoundsRes.jsonp_query tag: tag, (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = tag_regex.test(guess)

    $scope.$watch "correct", (correct) ->
      $state.go($state.$current, null, { reload: true }) if correct


rounds.controller 'RoundCtrl', RoundCtrl
