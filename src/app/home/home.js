(function() {
  var home, homeConfig, homeController, modules;

  modules = ['ui.router', 'cfp.hotkeys'];

  home = angular.module('tumblrGame.home', modules);

  homeConfig = function($stateProvider) {
    return $stateProvider.state("home", {
      url: "/home",
      views: {
        main: {
          controller: "HomeCtrl",
          templateUrl: "home/home.tpl.html"
        }
      },
      data: {
        pageTitle: "Home"
      }
    });
  };

  homeConfig.$inject = ['$stateProvider'];

  home.config(homeConfig);

  homeController = function($scope, $state, hotkeys) {
    $scope.play = function() {
      return $state.transitionTo("select");
    };
    return hotkeys.bindTo($scope).add({
      combo: "enter",
      description: "Next Stage",
      callback: $scope.play
    });
  };

  homeController.$inject = ['$scope', '$state', 'hotkeys'];

  home.controller('HomeCtrl', homeController);

}).call(this);
