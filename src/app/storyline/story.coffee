modules = [
  'ui.router',

  'common.directives',
  'common.tags',
  'common.user_storage',

  'rounds.services',
  'cfp.hotkeys'

  'cfp.hotkeys',
  'rounds.services'
]

storyline = angular.module 'tumblrGame.storyline', modules

storylineConfig = ($stateProvider) ->
  $stateProvider.state "story",
    params: ["type", "category"]
    views:
      header:
        controller: "HeaderCtrl"
        templateUrl: "rounds/views/header.tpl.html"
      main:
        controller: "StoryCtrl"
        templateUrl: "storyline/story.tpl.html"
    data:
      pageTitle: "Round Start"


storylineConfig.$inject = ['$stateProvider']
storyline.config storylineConfig

class StoryCtrl
  @$inject: ['$scope', 'TagsService', 'RandomDateService', 'StoryService', 'gameStorage', 'RoundsRes', '$state', '$stateParams', 'hotkeys', 'imagePreloader']

  constructor: ($scope, TagsService, RandomDateService, StoryService, gameStorage, RoundsRes, $state, $stateParams, hotkeys, imagePreloader) ->
    $scope.round = gameStorage.get('current_round')
    $scope.storyline = StoryService.get_story(($scope.round), $stateParams.type)

    $scope.category = $stateParams.category || 'tv series'
    tag_index = TagsService.random_tag_index($scope.category)
    tag = TagsService.tag($scope.category, tag_index)
    before_date = RandomDateService.fromPastMonths(12) # past year

    $scope.posts = []

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
      ), ( (image) ->
        # Loading failed on at least one image, but that's ok
        $scope.isLoading = false
        $scope.isSuccessful = false
        console.error "Image Failed", image
        console.info "Preload Failure"
      ), (event) ->
        $scope.percentLoaded = event.percent
        console.info "Percent loaded:", event.percent

    $scope.dialogID = 0

    $scope.next = ->
      if $scope.dialogID < ($scope.storyline.length - 1)
        $scope.dialogID = $scope.dialogID + 1
      else
        $scope.start()

    $scope.start = ->
      $state.transitionTo "round", category: $stateParams.category, index: tag_index, before: before_date # can't pass objects yet with ui-router, so work around

    hotkeys.bindTo($scope).add
      combo: "space"
      description: "Next"
      callback: $scope.next

    hotkeys.bindTo($scope).add
      combo: "enter"
      description: "Skip"
      callback: $scope.start

storyline.controller 'StoryCtrl', StoryCtrl

class Dialog
  constructor: (@content, @type = "modal", @speaker, @button) ->

storyline.service "StoryService", ->

  check_points = {
    "1_start": [
        new Dialog("You're a bit confused by the premise of this test, so you message your mentor."),
        new Dialog("Kcklqkla, if this test is pulling the latest posts from Tumblr, what guarantee is there that the posts would make sense in the context of the test? Humans sometimes tag things incorrectly.", "message U", "you"),
        new Dialog("Oh, there's no guarantee. Sometimes it's gibberish. Sometimes it's human pornography. Have fun.", "message K", "kcklqkla"),
        new Dialog("That was discouraging. The High Council is a cruel organization.")
      ],
    "2_start": [
      new Dialog("Your friend Becky messages you before this round."),
      new Dialog("omg, i bet you cant beat my hi score of 250!! ur such a loser", "message B", "becky"),
      new Dialog("She's kinda mean. Why are you friends with Becky again?")
    ],
    "3_start": [
      new Dialog("You receive a message from Kcklqkla before this latest round."),
      new Dialog("Hey, did you know that you can use keyboard shortcuts in this game? Just hit enter at most screens, and then in the round selection page you can use alt/option + (1,2,3,4).", "message K", "kcklqkla"),
      new Dialog("Ugh, why didn't she tell you this sooner?")
    ],
    "7_start": [
      new Dialog("hey loser have u gotten 250 yet, i bet u havent", "message B", "becky")
    ],
    "12_start": [
      new Dialog("r u still not at 250 looool", "message B", "becky")
    ]
  }
  random_chapters = {
    "start": [
      [
        new Dialog("Your mentor offers you words of encouragement."),
        new Dialog("Even if you fail your studies, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.", "message K", "kcklqkla"),
        new Dialog("You do not find this encouraging.")
      ],
      [
        new Dialog("Your mentor offers you words of encouragement."),
        new Dialog("Hey, if you're lazy, you can always study to be a Juggalo!", "message K", "kcklqkla"),
        new Dialog("You do not find this encouraging.")
      ],
      [
        new Dialog("Hey, what do you want your human persona to be? The High Council is asking.", "message K", "kcklqkla"),
        new Dialog("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.", "message U", "you"),
        new Dialog("... I'm going to put you down as a 20-something male then.", "message K", "kcklqkla")
      ],
      [
        new Dialog("hey what will ur human persona be", "message B", "becky"),
        new Dialog("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.", "message U", "you"),
        new Dialog("YOUR DELUSIONAL. EVERYBODY KNOWS YOU CANT TIE DOWN PINKIE PIE LIKE THAT.", "message B", "becky")
      ],
      [
        new Dialog("You think your mentor, Kcklqkla, is acting especially awkward around you. You suspect that they have read your smutty fanfics.")
      ],
      [
        new Dialog("You receive another message from your friend Becky."),
        new Dialog("at this rate you'll never get to earth... #earthlings... #thatcouldbeusbutuplayin", "message B", "becky"),
        new Dialog("I don't think Becky understands hashtags.")
      ],
      [
        new Dialog("You feel extremely nervous about this test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")
      ],
      [
        new Dialog("hey loser i just got into this band u prolly never heard of em", "message B", "becky"),
        new Dialog("Uh, what band?", "message U", "you"),
        new Dialog("their called one direction they are sooooooo cuteee", "message B", "becky"),
        new Dialog("Becky always has impeccable taste. You're jealous.")
      ],
      [
        new Dialog("Try practicing your best impression of a cool human to me.", "message K", "kcklqkla"),
        new Dialog("Oh, well, I just started listening to the COOLEST podcast--", "message U", "you"),
        new Dialog("You must be mistaken. I said cool. Cool in the Humanese English language doesn't mean loser.", "message K", "kcklqkla")
      ],
      [
        new Dialog("I think I'm going to be one of those food bloggers when I'm undercover as a human. But I mean, never making anything though. Just one of those humans that just reblogs photos of pizza.", "message U", "you"),
      ],
      [
        new Dialog("What will your human persona's aspirations be?", "message K", "kcklqkla"),
        new Dialog("I think I wanna be a really famous gifset maker.", "message U", "you"),
        new Dialog("I meant career goals.", "message K", "kcklqkla"),
        new Dialog("Career? In this economy?", "message U", "you"),
        new Dialog("Kcklqkla seems impressed by your ad-lib. Just like a real human!")
      ],
      [
        new Dialog("Oh man, Becky, did you see the latest--", "message U", "you"),
        new Dialog("STOP! SPOILERS!", "message B", "becky"),
        new Dialog("I didn't even finish!", "message U", "you"),
        new Dialog("UGH JUST SAYING THE TITLE OF WHATEVER U WERE GONNA SAY IS A SPOILER", "message B", "becky")
      ],
      [
        new Dialog("Becky and you are practicing talking about video games under the watchful eye of Kcklqkla.")
        new Dialog("ugh i hate her she's the worst", "message B", "becky"),
        new Dialog("Becky, I'm pretty sure that your interpretation is based purely on the popularized fanon version of the character. i'm sure you'd feel differently if you go back to the original Japanese version.", "message U", "you"),
        new Dialog("That was a pretty impressive ad-lib. Well done.")
      ]
    ]
  }
  service = {
    get_story: (round, stage) ->
      if "#{round}_#{stage}" of check_points
        chapter = check_points["#{round}_#{stage}"]
      else
        all_chapters = random_chapters[stage]
        chapter = all_chapters[Math.floor(Math.random() * all_chapters.length)]
      
      return chapter
  }
  service
