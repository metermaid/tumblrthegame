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


directives.directive "focus", ($timeout) ->
  link: (scope, element, attrs) ->
    scope.$watch attrs.focus, (value) ->
      if value is true        
        element[0].focus()
        scope[attrs.focus] = false