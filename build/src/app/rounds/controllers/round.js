(function() {
  var RoundCtrl, rounds;

  rounds = angular.module('tumblrGame.rounds');

  RoundCtrl = (function() {
    RoundCtrl.$inject = ['$scope', 'TagsService', 'RandomDateService', 'RoundsRes', 'gameStorage', '$state', '$stateParams', '$timeout'];

    function RoundCtrl($scope, TagsService, RandomDateService, RoundsRes, gameStorage, $state, $stateParams, $timeout) {
      var before_date, tag, tag_regex, timeout;
      $scope.round = gameStorage.get('current_round');
      $scope.type = $stateParams.type || 'series';
      $scope.roundStartTime = Date.now();
      $scope.secondsLeft = 10;
      tag = TagsService.random_tag($scope.type);
      $scope.correct = false;
      $scope.guess = "";
      tag_regex = new RegExp("^#?" + tag.regex.source + "$", "i");
      before_date = RandomDateService.fromPastMonths(12);
      RoundsRes.jsonp_query({
        tag: tag.name,
        before: before_date
      }, function(response) {
        $scope.message = response.meta;
        return $scope.posts = response.response;
      });
      $scope.$watch("guess", function(guess) {
        if (!guess || guess.length === 0) {
          return 0;
        }
        $scope.correct = guess.search(tag_regex) !== -1;
        return $scope.correct;
      });
      $scope.$watch("correct", function(correct) {
        if (correct) {
          gameStorage.increment('current_round', 1);
          $scope.stop();
          return $state.transitionTo("end", {
            tag: tag.name,
            before: before_date,
            win: true
          });
        }
      });
      timeout = null;
      $scope.onTimeout = function() {
        $scope.secondsLeft--;
        if ($scope.secondsLeft >= 1) {
          return timeout = $timeout($scope.onTimeout, 1000);
        } else {
          $scope.stop();
          return $state.transitionTo("end", {
            tag: tag.name,
            before: before_date,
            win: false
          });
        }
      };
      timeout = $timeout($scope.onTimeout, 1000);
      $scope.stop = function() {
        return $timeout.cancel(timeout);
      };
    }

    return RoundCtrl;

  })();

  rounds.controller('RoundCtrl', RoundCtrl);

}).call(this);
