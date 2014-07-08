
modules = [
  'ui.router',
  'common.user_storage',
  'common.tags',
  'ngResource'
]

rounds = angular.module 'tumblrGame.rounds', modules

roundsConfig = ($stateProvider) ->
  $stateProvider.state "select",
    url: "/play"
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/header.tpl.html"
      main:
        controller: "SelectCtrl"
        templateUrl: "rounds/select.tpl.html"
    data:
      pageTitle: "Select a Category"
  $stateProvider.state "round",
    params: ["type"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/header.tpl.html"
      main:
        controller: "RoundCtrl"
        templateUrl: "rounds/round.tpl.html"
    data:
      pageTitle: "Round Start"
  $stateProvider.state "end",
    params: ["tag", "before"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/header.tpl.html"
      main:
        controller: "EndCtrl"
        templateUrl: "rounds/end.tpl.html"
    data:
      pageTitle: "Congratulations"

roundsConfig.$inject = ['$stateProvider']
rounds.config roundsConfig

rounds.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK", {},
      jsonp_query:
        cache: true
        method: "JSONP"
    )
]

# gives a random timestamp from the last number of months
rounds.service "RandomDateService", ->
  service =
    oneMonth: 2678400
    fromPastMonths: (months) ->
      (Date.now() - (Math.floor(Math.random() * service.oneMonth * months))) / 1000



class HeaderCtrl
  @$inject: ['$scope', 'gameStorage', '$state']

  constructor: ($scope, gameStorage, $state) ->
    $scope.round = gameStorage.get('current_round')
    $scope.end = ($state.current.name == 'end')


rounds.controller 'HeaderCtrl', HeaderCtrl

class SelectCtrl
  @$inject: ['$scope', 'TagsService', 'gameStorage', '$state']

  constructor: ($scope, TagsService, gameStorage, $state) ->
    $scope.round = gameStorage.get('current_round')
    $scope.categories = TagsService.random_categories(4)

    $scope.play = (category) ->
      $state.transitionTo "round", {type: category}


rounds.controller 'SelectCtrl', SelectCtrl

class RoundCtrl
  @$inject: ['$scope', 'TagsService', 'RandomDateService', 'RoundsRes', 'gameStorage', '$state', '$stateParams']

  constructor: ($scope, TagsService, RandomDateService, RoundsRes, gameStorage, $state, $stateParams) ->
    $scope.round = gameStorage.get('current_round')
    $scope.type = $stateParams.type || 'series'
    tag = TagsService.random_tag($scope.type)
    $scope.correct = false
    $scope.guess = ""
    tag_regex = tag.regex
    before_date = RandomDateService.fromPastMonths(12) # past year
    RoundsRes.jsonp_query tag: tag.name, before: before_date, (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = guess.search(tag.regex) != -1
      $scope.correct

    $scope.$watch "correct", (correct) ->
      if correct
        gameStorage.increment('current_round', 1)
        $state.transitionTo "end", tag: tag, before: before_date


rounds.controller 'RoundCtrl', RoundCtrl

class EndCtrl
  @$inject: ['$scope', 'RoundsRes', 'gameStorage', '$filter', '$state', '$stateParams']

  constructor: ($scope, RoundsRes, gameStorage, $filter, $state, $stateParams) ->
    $scope.round = gameStorage.get('current_round')

    RoundsRes.jsonp_query tag: 'reaction-gif', before:$stateParams.before, (response) ->
      yay_gifs = $filter('filter')(response.response, { type : 'photo' })
      $scope.gif = yay_gifs[0].photos[0].original_size.url

    RoundsRes.jsonp_query tag: $stateParams.tag, before: $stateParams.before, (response) ->
      $scope.posts = response.response

    $scope.play = ->
      $state.transitionTo "select"


rounds.controller 'EndCtrl', EndCtrl
