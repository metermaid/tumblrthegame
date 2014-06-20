
modules = [
  'ui.router',
  'common.user_storage',
  'ngResource'
]

rounds = angular.module 'tumblrGame.rounds', modules

roundsConfig = ($stateProvider) ->
  $stateProvider.state "select",
    url: "/play"
    views:
      main:
        controller: "SelectCtrl"
        templateUrl: "rounds/select.tpl.html"
    data:
      pageTitle: "Select a Category"
  $stateProvider.state "round",
    params: ["type"]
    views:
      main:
        controller: "RoundCtrl"
        templateUrl: "rounds/round.tpl.html"
    data:
      pageTitle: "Round Start"

roundsConfig.$inject = ['$stateProvider']
rounds.config roundsConfig

rounds.service "TagsService", ->
  service =
    all_tags: {
        'TV series': ["adventure time", "supernatural", "doctor who", "sherlock", "community", "parks and recreation", "the big bang theory"],
        'characters': ["hannibal lecter", "mako mori", "katniss everdeen"],
        'homestuck': ['dave strider', 'roxy lalonde', 'nepeta', 'john egert', 'vriska serket', 'tavros nitram', 'terezi', 'equius']
        'marvel': ["spiderman", "avengers", "iron man", "doctor strange", "hulk", "captain america", "fantastic four"],
        'dog breeds': ["corgis", "pomeranians", "beagles", "shiba inu", "greyhounds", "huskies", "Chihuahuas", "bulldogs"],
        'disney princesses': ["snow white", "jasmine", "cinderella", "aurora", "ariel", "belle", "pocahontas", "mulan", "tiana", "rapunzel", "merida"]
        'anime': ['cowboy bebop', 'space dandy', 'kill la kill', 'attack on titan']
    }
    random_categories: (length) ->
      categories = Object.keys(service.all_tags)
      # From the end of the list to the beginning, pick element `i`.
      for i in [categories.length-1..1]
        # Choose random element `j` to the front of `i` to swap with.
        j = Math.floor Math.random() * (i + 1)
        # Swap `j` with `i`, using destructured assignment
        [categories[i], categories[j]] = [categories[j], categories[i]]
      # Return the shuffled array.
      categories.slice(0,length)

    random_tag: (type) ->
      tags = service.all_tags[type]
      return tags[Math.floor(Math.random() * tags.length)]

rounds.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("http://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK", {},
      jsonp_query:
        tag: @tag
        method: "JSONP"
    )
]

# gives a random timestamp from the last number of months
rounds.service "RandomDateService", ->
  service = 
    oneMonth: 2678400
    fromPastMonths: (months) ->
      (Date.now() - (Math.floor(Math.random() * service.oneMonth * months))) / 1000

class SelectCtrl
  @$inject: ['$scope', 'TagsService', 'gameStorage', '$state']

  constructor: ($scope, TagsService, gameStorage, $state) ->
    $scope.round = gameStorage.get('current_round')
    $scope.categories = TagsService.random_categories(6)

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
    tag_regex = new RegExp('^#'+tag+'$', "i")
    RoundsRes.jsonp_query tag: tag, before: RandomDateService.fromPastMonths(12), (response) ->
      $scope.message = response.meta
      $scope.posts = response.response

    $scope.$watch "guess", (guess) ->
      return 0  if not guess or guess.length is 0
      $scope.correct = tag_regex.test(guess)

    $scope.$watch "correct", (correct) ->
      if correct
        gameStorage.increment('current_round', 1)
        $state.transitionTo "select"


rounds.controller 'RoundCtrl', RoundCtrl
