(function(){var e,o;o=angular.module("tumblrGame.rounds"),e=function(){function e(e,o,r,n,t){e.round=r.get("current_round"),e.score=r.get("score"),e.returnToHome=function(){return n.transitionTo("home")},e.shareScore=function(){},t.bindTo(e).add({combo:"enter",description:"Return to Home",callback:e.returnToHome})}return e.$inject=["$scope","TagsService","gameStorage","$state","hotkeys"],e}(),o.controller("LoseCtrl",e)}).call(this);