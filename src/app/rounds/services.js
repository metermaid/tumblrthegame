(function(){var e,o;e=["ngResource"],o=angular.module("rounds.services",e),o.factory("RoundsRes",["$resource",function(e){return e("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK",{},{jsonp_query:{cache:!0,method:"JSONP"}})}]),o.service("RandomDateService",function(){var e;return e={oneMonth:2678400,fromPastMonths:function(o){return(Date.now()-Math.floor(Math.random()*e.oneMonth*o))/1e3}}})}).call(this);