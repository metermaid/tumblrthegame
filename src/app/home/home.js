(function(){var e,t,o,r;r=["ui.router","cfp.hotkeys"],e=angular.module("tumblrGame.home",r),t=function(e){return e.state("home",{url:"/home",views:{main:{controller:"HomeCtrl",templateUrl:"home/home.tpl.html"}},data:{pageTitle:"Home"}})},t.$inject=["$stateProvider"],e.config(t),o=function(e,t,o,r){return e.play=function(){return r.put("score",0),r.put("lives",5),t.transitionTo("select")},o.bindTo(e).add({combo:"enter",description:"Next Stage",callback:e.play})},o.$inject=["$scope","$state","hotkeys","gameStorage"],e.controller("HomeCtrl",o)}).call(this);