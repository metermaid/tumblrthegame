(function() {
  var imagePreloader, preloader_module,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  preloader_module = angular.module("common.preloader", []);

  imagePreloader = function($q, $rootScope) {
    var Preloader;
    Preloader = (function() {
      function Preloader(imageLocations) {
        this.loadImageLocation = __bind(this.loadImageLocation, this);
        this.handleImageLoad = __bind(this.handleImageLoad, this);
        this.handleImageError = __bind(this.handleImageError, this);
        this.imageLocations = imageLocations;
        this.imageCount = this.imageLocations.length;
        this.loadCount = 0;
        this.errorCount = 0;
        this.states = {
          PENDING: 1,
          LOADING: 2,
          RESOLVED: 3,
          REJECTED: 4
        };
        this.state = this.states.PENDING;
        this.deferred = $q.defer();
        this.promise = this.deferred.promise;
      }

      Preloader.preloadImages = function(imageLocations) {
        var preloader;
        preloader = new Preloader(imageLocations);
        return preloader.load();
      };

      Preloader.prototype.isInitiated = function() {
        return this.state !== this.states.PENDING;
      };

      Preloader.prototype.isRejected = function() {
        return this.state === this.states.REJECTED;
      };

      Preloader.prototype.isResolved = function() {
        return this.state === this.states.RESOLVED;
      };

      Preloader.prototype.load = function() {
        var i, _i, _ref;
        if (this.isInitiated()) {
          return this.promise;
        }
        this.state = this.states.LOADING;
        for (i = _i = 0, _ref = this.imageCount - 1; _i <= _ref; i = _i += 1) {
          this.loadImageLocation(this.imageLocations[i]);
        }
        return this.promise;
      };

      Preloader.prototype.handleImageError = function(imageLocation) {
        this.errorCount++;
        if (this.isRejected()) {
          return;
        }
        this.state = this.states.REJECTED;
        return this.deferred.reject(imageLocation);
      };

      Preloader.prototype.handleImageLoad = function(imageLocation) {
        this.loadCount++;
        if (this.isRejected()) {
          return;
        }
        this.deferred.notify({
          percent: Math.ceil(this.loadCount / this.imageCount * 100),
          imageLocation: imageLocation
        });
        if (this.loadCount === this.imageCount) {
          this.state = this.states.RESOLVED;
          return this.deferred.resolve(this.imageLocations);
        }
      };

      Preloader.prototype.loadImageLocation = function(imageLocation) {
        var image, preloader, _onErrorHandler, _onLoadHandler;
        preloader = this;
        image = null;
        _onLoadHandler = function(event) {
          return $rootScope.$apply(function() {
            preloader.handleImageLoad(event.target.src);
            return preloader = image = event = null;
          });
        };
        _onErrorHandler = function(event) {
          return $rootScope.$apply(function() {
            preloader.handleImageError(event.target.src);
            return preloader = image = event = null;
          });
        };
        image = new Image();
        image.onload = _onLoadHandler;
        image.onerror = _onErrorHandler;
        return image.src = imageLocation;
      };

      return Preloader;

    })();
    return Preloader;
  };

  preloader_module.factory("imagePreloader", ['$q', '$rootScope', imagePreloader]);

}).call(this);
