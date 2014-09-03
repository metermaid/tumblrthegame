directives = angular.module "common.directives", []

directives.directive "shaker", [
  "$animate"
  ($animate) ->
     link: (scope, element, attrs) ->
        element.bind "keydown keypress", (event) ->
          if event.which == 13
            scope.$apply ->
              $animate.addClass element, "shake",
                $animate.removeClass element, "shake"
]