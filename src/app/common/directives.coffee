directives = angular.module "common.directives", []

directives.directive "focus", ($timeout) ->
  link: (scope, element, attrs) ->
    scope.$watch attrs.focus, (value) ->
      if value is true
        console.log "value=", value
        
        element[0].focus()
        scope[attrs.focus] = false

directives.directive "keypressEvents", [
   "$document"
   "$rootScope"
   ($document, $rootScope) ->
      return (
         restrict: "A"
         link: ->
            $document.bind "keypress", (e) ->
               $rootScope.$broadcast "keypress", e
               $rootScope.$broadcast "keypress:" + e.which, e