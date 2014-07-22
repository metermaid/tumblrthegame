(function() {
  var SelectCtrl, rounds;

  rounds = angular.module('tumblrGame.rounds');

  SelectCtrl = (function() {
    SelectCtrl.$inject = ['$scope', 'TagsService', 'gameStorage', '$state', 'hotkeys'];

    function SelectCtrl($scope, TagsService, gameStorage, $state, hotkeys) {
      var category, index, makeHotKey, num_categories, _i, _len, _ref;
      num_categories = 4;
      $scope.round = gameStorage.get('current_round');
      $scope.categories = TagsService.random_categories(num_categories);
      $scope.play = function(category) {
        var i, _i;
        for (i = _i = 0; _i <= num_categories; i = _i += 1) {
          hotkeys.del("ctrl+" + (i + 1));
        }
        return $state.transitionTo("round", {
          type: category
        });
      };
      makeHotKey = function(category, index) {
        return hotkeys.add({
          combo: "ctrl+" + (index + 1),
          description: "Go to " + category + " Stage",
          callback: function() {
            return $scope.play(category);
          }
        });
      };
      _ref = $scope.categories;
      for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
        category = _ref[index];
        makeHotKey(category, index);
      }
    }

    return SelectCtrl;

  })();

  rounds.controller('SelectCtrl', SelectCtrl);

}).call(this);
