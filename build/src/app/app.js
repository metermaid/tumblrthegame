(function(){var e,t,o,r;r=["templates","common.directives","common.preloader","common.tags","common.user_storage","tumblrGame.home","tumblrGame.rounds","rounds.services","ui.router","cfp.hotkeys"],o=angular.module("tumblrGame",r),e=function(e,t){return t.otherwise("/home")},e.$inject=["$stateProvider","$urlRouterProvider"],o.config(e),t=function(e){return e.$on("$stateChangeSuccess",function(t,o){return angular.isDefined(o.data.pageTitle)?e.pageTitle=o.data.pageTitle+" | Tumblr: THE GAME":void 0})},t.$inject=["$scope","$location"],o.controller("AppCtrl",t)}).call(this);