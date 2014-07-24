
modules = [
  'ui.router',

  'common.directives',
  'common.preloader',
  'common.tags',
  'common.user_storage',

  'tumblrGame.storyline',

  'ngResource',

  'rounds.services',
  'ngDialog',
  'cfp.hotkeys'
]

rounds = angular.module 'tumblrGame.rounds', modules

roundsConfig = ($stateProvider) ->
  $stateProvider.state "select",
    url: "/play"
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/views/header.tpl.html"
      main:
        controller: "SelectCtrl"
        templateUrl: "rounds/views/select.tpl.html"
    data:
      pageTitle: "Select a Category"
  $stateProvider.state "round",
    params: ["type"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/views/header.tpl.html"
      main:
        controller: "RoundCtrl"
        templateUrl: "rounds/views/round.tpl.html"
    data:
      pageTitle: "Round Start"
  $stateProvider.state "end",
    params: ["tag", "before", "win"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/views/header.tpl.html"
      main:
        controller: "EndCtrl"
        templateUrl: "rounds/views/end.tpl.html"
    data:
      pageTitle: "Round Over"

roundsConfig.$inject = ['$stateProvider']
rounds.config roundsConfig

# draft of a model
class tumblrPost
  constructor: (blog_name, url, type, reblog_key, tags, note_count, original_size_url, thumb_size_url) ->
