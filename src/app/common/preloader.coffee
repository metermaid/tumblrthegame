# -------------------------------------------------- //
# Preloader from http://www.bennadel.com/blog/2597-preloading-images-in-angularjs-with-promises.htm
# -------------------------------------------------- //

preloader = angular.module "common.preloader", []

# I provide a utility class for preloading image objects.
preloader.factory "ImagePreloader", ($q, $rootScope) ->
  
  # I manage the preloading of image objects. Accepts an array of image URLs.
  Preloader = (imageLocations) ->
    
    # I am the image SRC values to preload.
    @imageLocations = imageLocations
    
    # As the images load, we'll need to keep track of the load/error
    # counts when announing the progress on the loading.
    @imageCount = @imageLocations.length
    @loadCount = 0
    @errorCount = 0
    
    # I am the possible states that the preloader can be in.
    @states =
      PENDING: 1
      LOADING: 2
      RESOLVED: 3
      REJECTED: 4

    
    # I keep track of the current state of the preloader.
    @state = @states.PENDING
    
    # When loading the images, a promise will be returned to indicate
    # when the loading has completed (and / or progressed).
    @deferred = $q.defer()
    @promise = @deferred.promise
  
  # ---
  # STATIC METHODS.
  # ---
  
  # I reload the given images [Array] and return a promise. The promise
  # will be resolved with the array of image locations.
  Preloader.preloadImages = (imageLocations) ->
    preloader = new Preloader(imageLocations)
    preloader.load()

  
  # ---
  # INSTANCE METHODS.
  # ---
  Preloader:: =
    
    # Best practice for "instnceof" operator.
    constructor: Preloader
    
    # ---
    # PUBLIC METHODS.
    # ---
    
    # I determine if the preloader has started loading images yet.
    isInitiated: isInitiated = ->
      @state isnt @states.PENDING

    
    # I determine if the preloader has failed to load all of the images.
    isRejected: isRejected = ->
      @state is @states.REJECTED

    
    # I determine if the preloader has successfully loaded all of the images.
    isResolved: isResolved = ->
      @state is @states.RESOLVED

    
    # I initiate the preload of the images. Returns a promise.
    load: load = ->
      
      # If the images are already loading, return the existing promise.
      return (@promise)  if @isInitiated()
      @state = @states.LOADING
      i = 0

      while i < @imageCount
        @loadImageLocation @imageLocations[i]
        i++
      
      # Return the deferred promise for the load event.
      @promise

    
    # ---
    # PRIVATE METHODS.
    # ---
    
    # I handle the load-failure of the given image location.
    handleImageError: handleImageError = (imageLocation) ->
      @errorCount++
      
      # If the preload action has already failed, ignore further action.
      return  if @isRejected()
      @state = @states.REJECTED
      @deferred.reject imageLocation

    
    # I handle the load-success of the given image location.
    handleImageLoad: handleImageLoad = (imageLocation) ->
      @loadCount++
      
      # If the preload action has already failed, ignore further action.
      return  if @isRejected()
      
      # Notify the progress of the overall deferred. This is different
      # than Resolving the deferred - you can call notify many times
      # before the ultimate resolution (or rejection) of the deferred.
      @deferred.notify
        percent: Math.ceil(@loadCount / @imageCount * 100)
        imageLocation: imageLocation

      
      # If all of the images have loaded, we can resolve the deferred
      # value that we returned to the calling context.
      if @loadCount is @imageCount
        @state = @states.RESOLVED
        @deferred.resolve @imageLocations

    
    # I load the given image location and then wire the load / error
    # events back into the preloader instance.
    # --
    # NOTE: The load/error events trigger a $digest.
    loadImageLocation: loadImageLocation = (imageLocation) ->
      preloader = this
      
      image = $(new Image()).load((event) ->
        $rootScope.$apply ->
          preloader.handleImageLoad event.target.src
          preloader = image = event = null
        $rootScope.$apply ->
          preloader.handleImageError event.target.src
          preloader = image = event = null
      ).prop("src", imageLocation)

  
  # Return the factory instance.
  Preloader