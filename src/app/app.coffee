modules = [
  'templates',
  
  'common.directives',
  'common.preloader',
  'common.tags',
  'common.user_storage',

  'tumblrGame.home',
  'tumblrGame.rounds',
  'tumblrGame.storyline',
  
  'story.services',
  'rounds.services',

  'cfp.hotkeys',
  'ngAnimate'
  
  'ui.router',
  'angular-google-analytics'
]

appModule = angular.module('tumblrGame', modules)

appConfig = ($stateProvider, $urlRouterProvider, AnalyticsProvider) ->
  $urlRouterProvider.otherwise '/home'
  AnalyticsProvider.setAccount "UA-397121-4"
  AnalyticsProvider.trackPages true
  AnalyticsProvider.ignoreFirstPageLoad true

appConfig.$inject = ['$stateProvider', '$urlRouterProvider', 'AnalyticsProvider']
appModule.config appConfig

appModule.run (Analytics) ->


appController = ($scope, $location) ->
  $scope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    if angular.isDefined(toState.data.pageTitle)
      $scope.pageTitle = toState.data.pageTitle + ' | Tumblr: THE GAME'

appController.$inject = ['$scope', '$location']
appModule.controller 'AppCtrl', appController
