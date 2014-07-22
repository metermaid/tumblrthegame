(function() {
  var EndCtrl, rounds;

  rounds = angular.module('tumblrGame.rounds');

  EndCtrl = (function() {
    EndCtrl.$inject = ['$scope', 'RoundsRes', 'gameStorage', '$filter', '$state', '$stateParams', 'hotkeys'];

    function EndCtrl($scope, RoundsRes, gameStorage, $filter, $state, $stateParams, hotkeys) {
      $scope.round = gameStorage.get('current_round');
      console.log("PARM: " + $stateParams.win);
      if ($stateParams.win === "true") {
        $scope.winMessage = "Correct! You win!";
      } else {
        $scope.winMessage = "Out of time! You didn't win.";
      }
      RoundsRes.jsonp_query({
        tag: 'reaction-gif',
        before: $stateParams.before
      }, function(response) {
        var yay_gifs;
        yay_gifs = $filter('filter')(response.response, {
          type: 'photo'
        });
        return $scope.gif = yay_gifs[0].photos[0].original_size.url;
      });
      RoundsRes.jsonp_query({
        tag: $stateParams.tag,
        before: $stateParams.before
      }, function(response) {
        return $scope.posts = response.response;
      });
      $scope.play = function() {
        return $state.transitionTo("select");
      };
      hotkeys.bindTo($scope).add({
        combo: "enter",
        description: "Next Stage",
        callback: $scope.play
      });
    }

    return EndCtrl;

  })();

  rounds.controller('EndCtrl', EndCtrl);

}).call(this);
