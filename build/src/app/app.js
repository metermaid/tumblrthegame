(function(){var e,t,r,o;o=["templates","common.directives","common.preloader","common.tags","common.user_storage","tumblrGame.home","tumblrGame.rounds","tumblrGame.storyline","rounds.services","cfp.hotkeys","ui.router"],r=angular.module("tumblrGame",o),e=function(e,t){return t.otherwise("/home")},e.$inject=["$stateProvider","$urlRouterProvider"],r.config(e),t=function(e){return e.$on("$stateChangeSuccess",function(t,r){return angular.isDefined(r.data.pageTitle)?e.pageTitle=r.data.pageTitle+" | Tumblr: THE GAME":void 0})},t.$inject=["$scope","$location"],r.controller("AppCtrl",t)}).call(this);