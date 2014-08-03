modules = [
  'templates',
  
  'common.directives',
  'common.preloader',
  'common.tags',
  'common.user_storage',

  'tumblrGame.home',
  'tumblrGame.rounds',
  'tumblrGame.storyline',

  'rounds.services',

  'cfp.hotkeys',
  
  'ui.router'
]

appModule = angular.module('tumblrGame', modules)

appConfig = ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/home'

appConfig.$inject = ['$stateProvider', '$urlRouterProvider']
appModule.config appConfig


appController = ($scope, $location) ->
  $scope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    if angular.isDefined(toState.data.pageTitle)
      $scope.pageTitle = toState.data.pageTitle + ' | Tumblr: THE GAME'

appController.$inject = ['$scope', '$location']
appModule.controller 'AppCtrl', appController
