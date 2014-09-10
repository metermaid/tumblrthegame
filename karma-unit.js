module.exports = function(config) {
  config.set({
    /**
     * This is the list of file patterns to load into the browser during testing.
     */
    files: [
      'vendor/angular/angular.js',
      'vendor/angular-ui-router/release/angular-ui-router.js',
      'vendor/angular-hotkeys/build/hotkeys.js',
      'vendor/angular-mocks/angular-mocks.js',
      'vendor/angular-animate/angular-animate.js',
      'vendor/angular-google-analytics/dist/angular-google-analytics.js',
      'vendor/angular-resource/angular-resource.js',
      'build/src/templates.js',
      'src/*/*/*.coffee', // include root modules before controller modules
      'src/**/*.coffee'
    ],
    exclude: [
      'src/**/*.scenario.coffee'
    ],
    frameworks: [ 'jasmine' ],
    plugins: [ 
          'karma-jasmine',
          'karma-chrome-launcher',
          'karma-coverage',
          'karma-coffee-preprocessor',
          'karma-phantomjs-launcher'
           ],
    preprocessors: {
      'src/**/!(*.spec).coffee': ['coverage'],
      'src/**/*.spec.coffee': ['coffee']
    },

    /**
     * How to report, by default.
     */
    reporters: ['dots', 'coverage'],

    /**
     * On which port should the browser connect, on which port is the test runner
     * operating, and what is the URL path for the browser to use.
     */
    port: 9018,
    runnerPort: 9100,
    urlRoot: '/',

    /** 
     * Disable file watching by default.
     */
    autoWatch: false,

    /**
     * The list of browsers to launch to test on. This includes only "Firefox" by
     * default, but other browser names include:
     * Chrome, ChromeCanary, Firefox, Opera, Safari, PhantomJS
     *
     * Note that you can also use the executable name of the browser, like "chromium"
     * or "firefox", but that these vary based on your operating system.
     *
     * You may also leave this blank and manually navigate your browser to
     * http://localhost:9018/ when you're running tests. The window/tab can be left
     * open and the tests will automatically occur there during the build. This has
     * the aesthetic advantage of not launching a browser every time you save.
     */
    browsers: [
      'PhantomJS'
    ]
  });
};

