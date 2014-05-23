
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
      pageTitle: "Roundz"

roundsConfig.$inject = ['$stateProvider']
rounds.config roundsConfig

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

    RoundsRes.jsonp_query tag: "adventure time", (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

rounds.controller 'RoundsCtrl', RoundsCtrl
