modules = [
  'ui.router',
  'cfp.hotkeys'
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


homeController = ($scope, $state, hotkeys) ->
  # nothing in the example
  $scope.play = ->
    $state.transitionTo "select"

  hotkeys.bindTo($scope).add
    combo: "enter"
    description: "Next Stage"
    callback: $scope.play


homeController.$inject = ['$scope', '$state', 'hotkeys']
home.controller 'HomeCtrl', homeController

