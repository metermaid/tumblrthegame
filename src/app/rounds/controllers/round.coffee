rounds = angular.module 'tumblrGame.rounds'

class RoundCtrl
  @$inject: ['Analytics', '$scope', 'TagsService', 'RandomDateService', 'RoundsRes', 'gameStorage', '$state', '$stateParams', '$timeout', 'imagePreloader']

  constructor: (Analytics, $scope, TagsService, RandomDateService, RoundsRes, gameStorage, $state, $stateParams, $timeout, imagePreloader) ->
    # preloader stuff
    $scope.isLoading = true
    $scope.isSuccessful = false
    $scope.percentLoaded = 0


    # Prevent the backspace key from navigating back.
    Mousetrap.bind "backspace", (event) ->
      d = event.srcElement or event.target
      if d.tagName.toUpperCase() is "INPUT" and d.type.toUpperCase() is "TEXT"
        doPrevent = d.readOnly or d.disabled
      else
        doPrevent = true
      event.preventDefault()  if doPrevent

    $scope.round = gameStorage.get('current_round')

    $scope.category = $stateParams.category

    before_date = $stateParams.before
    tag = TagsService.tag($scope.category, $stateParams.index)
    tag_regex = new RegExp("^#?" + tag.regex.source + "$", "i")

    Analytics.addItem('round', $stateParams.category, tag, 1)


    $scope.posts = []

    # just in case the preloading from before didn't work...
    RoundsRes.jsonp_query tag: tag.name, before: before_date, (response) ->
      $scope.message = response.meta

      for post in response.response
        if post.type is "photo"
          $scope.posts.push post
          break if $scope.posts.length >= 6

      images = $scope.posts.map (post) -> post.photos[0].alt_sizes[1].url

      # Preload the images; then, update display when returned.
      imagePreloader.preloadImages(images).then ( (images) ->

        # Loading was successful.
        $scope.isLoading = false
        $scope.isSuccessful = true
        console.info "Preload Successful"
        timeout = $timeout($scope.onTimeout, 1000)

      ), ( (image) ->

        # Loading failed on at least one image, but that's ok
        $scope.isLoading = false
        $scope.isSuccessful = false
        console.error "Image Failed", image
        console.info "Preload Failure"
        timeout = $timeout($scope.onTimeout, 1000)

      ), (event) ->
        $scope.percentLoaded = event.percent
        console.info "Percent loaded:", event.percent

    $scope.secondsLeft = 15 # eventually put this in a file that's more more settings-y

    timeout = null

    $scope.onTimeout = ->
      $scope.secondsLeft--
      if $scope.secondsLeft >= 1
        timeout = $timeout($scope.onTimeout, 1000)
      else
        $scope.stop()
        gameStorage.increment('lives', -1)
        $scope.status = "lost"

        $timeout((->
          if gameStorage.get('lives') > 0
            $state.transitionTo "end", tag: tag.name, before: before_date, win: false
          else
            $state.transitionTo "lose"
          ), 500)
    $scope.stop = -> $timeout.cancel(timeout)


    $scope.status = "playing"
    $scope.guess = ""

    # scoring
    $scope.computePoints = (baseAmount, secondsLeft, secondsAlotted) ->
      return Math.floor(baseAmount + (baseAmount * (secondsLeft / secondsAlotted)))

    $scope.updateGuess = (guess) ->
      return 0 if not guess or guess.length is 0
      if guess.search(tag_regex) != -1
        $scope.status = "won" # if the redirect doesn't work, still want to respond
        gameStorage.increment('current_round', 1)
        gameStorage.increment('score', $scope.computePoints(10, $scope.secondsLeft, 10))
        $scope.stop()
        $timeout((->
          $state.transitionTo "end", tag: tag.name, before: before_date, win: true), 500)
        

rounds.controller 'RoundCtrl', RoundCtrl
