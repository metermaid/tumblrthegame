(function() {
  var HeaderCtrl, rounds;

  rounds = angular.module('tumblrGame.rounds');

  HeaderCtrl = (function() {
    HeaderCtrl.$inject = ['$scope', 'gameStorage', '$state'];

    function HeaderCtrl($scope, gameStorage, $state) {
      $scope.round = gameStorage.get('current_round');
      $scope.end = $state.current.name === 'end';
    }

    return HeaderCtrl;

  })();

  rounds.controller('HeaderCtrl', HeaderCtrl);

}).call(this);
