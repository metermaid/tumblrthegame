(function() {
  var modules, services;

  modules = ['ngResource'];

  services = angular.module('rounds.services', modules);

  services.factory("RoundsRes", [
    "$resource", function($resource) {
      return $resource("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK", {}, {
        jsonp_query: {
          cache: true,
          method: "JSONP"
        }
      });
    }
  ]);

  services.service("RandomDateService", function() {
    var service;
    return service = {
      oneMonth: 2678400,
      fromPastMonths: function(months) {
        return (Date.now() - (Math.floor(Math.random() * service.oneMonth * months))) / 1000;
      }
    };
  });

}).call(this);
