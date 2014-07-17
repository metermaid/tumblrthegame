directives = angular.module "common.directives", []

directives.directive "focus", ($timeout) ->
  link: (scope, element, attrs) ->
    scope.$watch attrs.focus, (value) ->
      if value is true        
        element[0].focus()
        scope[attrs.focus] = false