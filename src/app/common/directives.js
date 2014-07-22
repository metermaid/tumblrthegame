(function() {
  var directives;

  directives = angular.module("common.directives", []);

  directives.directive("focus", function($timeout) {
    return {
      link: function(scope, element, attrs) {
        return scope.$watch(attrs.focus, function(value) {
          if (value === true) {
            element[0].focus();
            return scope[attrs.focus] = false;
          }
        });
      }
    };
  });

}).call(this);
