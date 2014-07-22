(function() {
  var users;

  users = angular.module("common.user_storage", []);

  users.factory("gameStorage", function() {
    var defaults, service;
    defaults = {
      "current_round": 1,
      "score": 0
    };
    service = {
      get: function(storageID) {
        return sessionStorage.getItem(storageID) || defaults[storageID];
      },
      increment: function(storageID, n) {
        return service.put(storageID, parseInt(service.get(storageID)) + parseInt(n));
      },
      put: function(storageID, game) {
        return sessionStorage.setItem(storageID, game);
      }
    };
    return service;
  });

  users.factory("persistentStorage", function() {
    var defaults, service;
    defaults = {
      "high_score": 0
    };
    service = {
      get: function(storageID) {
        return localStorage.getItem(storageID) || defaults[storageID];
      },
      increment: function(storageID, n) {
        return service.put(storageID, parseInt(service.get(storageID)) + parseInt(n));
      },
      put: function(storageID, info) {
        return localStorage.setItem(storageID, info);
      }
    };
    return service;
  });

}).call(this);
