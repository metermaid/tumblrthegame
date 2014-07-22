(function() {
  var RoundCtrl, rounds;

  rounds = angular.module('tumblrGame.rounds');

  RoundCtrl = (function() {
    RoundCtrl.$inject = ['$scope', 'TagsService', 'RandomDateService', 'RoundsRes', 'gameStorage', '$state', '$stateParams', '$timeout', 'imagePreloader'];

    function RoundCtrl($scope, TagsService, RandomDateService, RoundsRes, gameStorage, $state, $stateParams, $timeout, imagePreloader) {
      var before_date, tag, tag_regex, timeout;
      $scope.isLoading = true;
      $scope.isSuccessful = false;
      $scope.percentLoaded = 0;
      $scope.round = gameStorage.get('current_round');
      $scope.type = $stateParams.type || 'series';
      tag = TagsService.random_tag($scope.type);
      tag_regex = new RegExp("^#?" + tag.regex.source + "$", "i");
      before_date = RandomDateService.fromPastMonths(12);
      $scope.posts = [];
      RoundsRes.jsonp_query({
        tag: tag.name,
        before: before_date
      }, function(response) {
        var images, post, _i, _len, _ref;
        $scope.message = response.meta;
        _ref = response.response;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          post = _ref[_i];
          if (post.type === "photo") {
            $scope.posts.push(post);
            if ($scope.posts.length >= 6) {
              break;
            }
          }
        }
        images = $scope.posts.map(function(post) {
          return post.photos[0].original_size.url;
        });
        return imagePreloader.preloadImages(images).then((function(images) {
          var timeout;
          $scope.isLoading = false;
          $scope.isSuccessful = true;
          console.info("Preload Successful");
          return timeout = $timeout($scope.onTimeout, 1000);
        }), (function(image) {
          var timeout;
          $scope.isLoading = false;
          $scope.isSuccessful = false;
          console.error("Image Failed", image);
          console.info("Preload Failure");
          return timeout = $timeout($scope.onTimeout, 1000);
        }), function(event) {
          $scope.percentLoaded = event.percent;
          return console.info("Percent loaded:", event.percent);
        });
      });
      $scope.secondsLeft = 10;
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
      $scope.stop = function() {
        return $timeout.cancel(timeout);
      };
      $scope.correct = false;
      $scope.guess = "";
      $scope.updateGuess = function(guess) {
        if (!guess || guess.length === 0) {
          return 0;
        }
        $scope.correct = guess.search(tag_regex) !== -1;
        return $scope.correct;
      };
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
    }

    return RoundCtrl;

  })();

  rounds.controller('RoundCtrl', RoundCtrl);

}).call(this);
