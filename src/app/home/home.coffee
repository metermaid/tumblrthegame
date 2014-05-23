modules = [
  'ui.router'
]

home = angular.module 'ngBoilerplate.home', modules

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


homeController = ($scope) ->
  # nothing in the example

homeController.$inject = ['$scope']
home.controller 'HomeCtrl', homeController


