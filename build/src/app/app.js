(function() {
  var appConfig, appController, appModule, modules;

  modules = ['templates', 'common.directives', 'common.user_storage', 'common.tags', 'tumblrGame.home', 'tumblrGame.rounds', 'rounds.services', 'ui.router', 'cfp.hotkeys'];

  appModule = angular.module('tumblrGame', modules);

  appConfig = function($stateProvider, $urlRouterProvider) {
    return $urlRouterProvider.otherwise('/home');
  };

  appConfig.$inject = ['$stateProvider', '$urlRouterProvider'];

  appModule.config(appConfig);

  appController = function($scope, $location) {
    return $scope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams) {
      if (angular.isDefined(toState.data.pageTitle)) {
        return $scope.pageTitle = toState.data.pageTitle + ' | Tumblr: THE GAME';
      }
    });
  };

  appController.$inject = ['$scope', '$location'];

  appModule.controller('AppCtrl', appController);

}).call(this);
