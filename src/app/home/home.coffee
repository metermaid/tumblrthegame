modules = [
  'ui.router'
]

home = angular.module 'tumblrGame.home', modules

homeConfig = ($stateProvider) ->
  $stateProvider.state "home",
    url: "/home"
    views:
      main:
        controller: "HomeCtrl"
        templateUrl: "home/home.tpl.html"

    data:
      pageTitle: "Home"

homeConfig.$inject = ['$stateProvider']
home.config homeConfig


homeController = ($scope, $state) ->
  # nothing in the example
  $scope.play = ->
    $state.transitionTo "select"


homeController.$inject = ['$scope', '$state']
home.controller 'HomeCtrl', homeController


