(function(){var e,t,r,n;n=["templates","common.directives","common.preloader","common.tags","common.user_storage","tumblrGame.home","tumblrGame.rounds","tumblrGame.storyline","story.services","rounds.services","cfp.hotkeys","ngAnimate","ui.router","angular-google-analytics"],r=angular.module("tumblrGame",n),e=function(e,t,r){return t.otherwise("/home"),r.setAccount("UA-397121-4"),r.trackPages(!0),r.useAnalytics(!0),r.useEnhancedLinkAttribution(!0)},e.$inject=["$stateProvider","$urlRouterProvider","AnalyticsProvider"],r.config(e),r.run(function(){}),t=function(e){return e.$on("$stateChangeSuccess",function(t,r){return angular.isDefined(r.data.pageTitle)?e.pageTitle=r.data.pageTitle+" | Tumblr: THE GAME":void 0})},t.$inject=["$scope","$location"],r.controller("AppCtrl",t)}).call(this);