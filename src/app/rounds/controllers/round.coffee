rounds = angular.module 'tumblrGame.rounds'

class RoundCtrl
  @$inject: ['$scope', 'TagsService', 'RandomDateService', 'RoundsRes', 'gameStorage', '$state', '$stateParams', '$timeout', 'ImagePreloader']

  constructor: ($scope, TagsService, RandomDateService, RoundsRes, gameStorage, $state, $stateParams, $timeout, ImagePreloader) ->
    # preloader stuff
    $scope.isLoading = true
    $scope.isSuccessful = false
    $scope.percentLoaded = 0

    $scope.round = gameStorage.get('current_round')

    $scope.type = $stateParams.type || 'series'
    tag = TagsService.random_tag($scope.type)
    tag_regex = new RegExp("^#?" + tag.regex.source + "$", "i")
    before_date = RandomDateService.fromPastMonths(12) # past year
    RoundsRes.jsonp_query tag: tag.name, before: before_date, (response) ->
      $scope.message = response.meta
      $scope.posts = []

      for post in response.response
        if post.type is "photo"
          $scope.posts.push post
          break if $scope.posts.length >= 6
      images = $scope.posts.map (post) -> post.photos[0].original_size.url


    $scope.correct = false
    $scope.guess = ""


    # Preload the images; then, update display when returned.
    ImagePreloader.preloadImages(images).then (handleResolve = (images) ->
      
      # Loading was successful.
      $scope.isLoading = false
      $scope.isSuccessful = true
      console.info "Preload Successful"


      $scope.roundStartTime = Date.now()
      $scope.secondsLeft = 20 # eventually put this in a file that's more more settings-y

      $scope.$watch "guess", (guess) ->
        return 0 if not guess or guess.length is 0
        $scope.correct = guess.search(tag_regex) != -1
        $scope.correct

      $scope.$watch "correct", (correct) ->
        if correct
          gameStorage.increment('current_round', 1)
          $scope.stop()
          $state.transitionTo "end", tag: tag.name, before: before_date, win: true

      timeout = null
      $scope.onTimeout = ->
        $scope.secondsLeft--
        if $scope.secondsLeft >= 1
          timeout = $timeout($scope.onTimeout, 1000)
        else
          $scope.stop()
          $state.transitionTo "end", tag: tag.name, before: before_date, win: false
      timeout = $timeout($scope.onTimeout, 1000)

      $scope.stop = -> $timeout.cancel(timeout)

    ), (handleReject = (image) ->
      
      # Loading failed on at least one image.
      $scope.isLoading = false
      $scope.isSuccessful = false
      console.error "Image Failed", image
      console.info "Preload Failure"
    ), handleNotify = (event) ->
      $scope.percentLoaded = event.percent
      console.info "Percent loaded:", event.percent


rounds.controller 'RoundCtrl', RoundCtrl
