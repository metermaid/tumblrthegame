
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

rounds.factory "RoundsRes", ($resource) ->
  $resource "http://api.tumblr.com/v2/tagged?api_key=fuiKNFp9vQFvjLNvx4sUwti4Yb5yGut&tag=fart"

class RoundsCtrl
  @$inject = ['$scope', '$filter', 'RoundsRes']

  constructor: ($scope, $filter, RoundsRes) ->
    $scope.posts = RoundsRes.query()

rounds.controller 'RoundsCtrl', RoundsCtrl
