(function(){var r,t;t=angular.module("tumblrGame.rounds"),r=function(){function r(r,t,e,n,o){var a,c,u,l,i,s,d;for(l=4,r.round=e.get("current_round"),r.categories=t.random_categories(l),r.play=function(r){var t,e;for(t=e=0;l>=e;t=e+=1)o.del("ctrl+"+(t+1));return n.transitionTo("round",{type:r})},u=function(t,e){return o.add({combo:"ctrl+"+(e+1),description:"Go to "+t+" Stage",callback:function(){return r.play(t)}})},d=r.categories,c=i=0,s=d.length;s>i;c=++i)a=d[c],u(a,c)}return r.$inject=["$scope","TagsService","gameStorage","$state","hotkeys"],r}(),t.controller("SelectCtrl",r)}).call(this);