var gulp = require('gulp');

var plugins = require('gulp-load-plugins')();
plugins.sass = require('gulp-ruby-sass');

var runSequence = require('run-sequence'); // needed for non-dependent ordered tasks

var protractor = require('gulp-protractor');

// Build Config

var build_dir = 'build';


var app_files = {  
  sass: [ 'src/style/**/*.scss' ],

  coffee: [ 'src/**/*.coffee', '!src/**/*.spec.coffee', '!src/**/*.scenario.coffee' ],

  spec: [ 'src/**/*.spec.coffee' ],

  protractor: [ 'src/**/*.scenario.coffee' ],

  atpl: [ 'src/app/**/*.tpl.html' ],
  ctpl: [ 'src/common/**/*.tpl.html' ],

  html: [ 'src/index.html' ],

  assets: [ 'src/assets/**/*.*' ]
};

var destinations = {  
  css: build_dir + "/style",
  js: build_dir + "/src",
  libs: build_dir + "/vendor",
  html: build_dir,
  assets: build_dir + "/assets",
};

var vendor_files = {
  js: [
    'vendor/angular/angular.js',
    'vendor/ngDialog/js/ngDialog.js',
    'vendor/angular-ui-router/release/angular-ui-router.js',
    'vendor/angular-resource/angular-resource.js'
  ],
  css: [
  ],
  assets: [
  ]
};

// libraries are manually injected because they need to go in order...
// TODO: think of a better way to do this.

var index_paths = [
  destinations.libs + "/angular.js",
  destinations.libs + "/ngDialog.js",
  destinations.libs + "/angular-ui-router.js",
  destinations.libs + "/angular-resource.js",
  destinations.js + "/**/*.js",
  destinations.js + "/templates.js",
  destinations.css + "/*.css"
];

var karma = require('gulp-karma')({
    configFile: 'karma-unit.js'
});

// Compilation Tasks

gulp.task('clean', function () {
    return gulp.src(['build/'], {read: false})
        .pipe(plugins.clean());
});

gulp.task('styles', function() {
  return gulp.src(app_files.sass)
        .pipe(plugins.sass({sourcemap:true}))
        .pipe(gulp.dest(destinations.css));
});

gulp.task('compile', function () {
    return gulp.src(app_files.coffee)
        .pipe(plugins.coffee({emitError: false}))
        .pipe(plugins.uglify())
        .pipe(gulp.dest(destinations.js));
});

gulp.task('coffeelint', function () {
    return gulp.src(app_files.coffee)
        .pipe(coffeelint())
        .pipe(coffeelint.reporter());
});

gulp.task('templates', function () {
    return gulp.src(app_files.atpl)
        .pipe(plugins.ngHtml2js({moduleName: 'templates'}))
        .pipe(plugins.concat('templates.js'))
        .pipe(plugins.uglify())
        .pipe(gulp.dest(destinations.js));
});

gulp.task('vendors', ['vendors-js']);
// dependencies can't be empty, so just js for now. see:
// https://github.com/ck86/gulp-bower-files/issues/21

gulp.task('vendors-js', function () {
    return gulp.src(vendor_files.js)
        .pipe(gulp.dest(destinations.libs));
});

gulp.task('vendors-css', function () {
    return gulp.src(vendor_files.css)
        .pipe(gulp.dest(destinations.css));
});

gulp.task('vendors-assets', function () {
    return gulp.src(vendor_files.assets)
        .pipe(gulp.dest(destinations.assets));
});

gulp.task('assets', function () {
    return gulp.src(app_files.assets)
        .pipe(gulp.dest(destinations.assets));
});

gulp.task('index', function () {
    return gulp.src(app_files.html)
        .pipe(plugins.inject(gulp.src(index_paths, {read: false})
          .pipe(plugins.print())
        ,{ ignorePath: build_dir, addRootSlash: false }))
        .pipe(gulp.dest(destinations.html));
});

// Testing Tasks

gulp.task('karma', function () {
    return karma.once();
});

gulp.task('karma-autowatch', function () {
    return karma.start({autoWatch: true});
});

gulp.task('webdriver_update', protractor.webdriver_update);

gulp.task('protractor', ['webdriver_update'], function () {
    return gulp.src(app_files.protractor)
    .pipe(protractor.protractor({
        configFile: 'protractor.config.js'
    }));
});

gulp.task('tests', function() {
  runSequence('karma',
    'protractor'); // having them print asynchronously is confusing
});

// Main Tasks

gulp.task('watch', function() {
  gulp.watch(app_files.sass, ['styles']);
  gulp.watch(app_files.coffee, ['compile']);
  gulp.watch([app_files.atpl, app_files.ctpl], ['templates']);
  gulp.watch(app_files.assets, ['assets']);
  gulp.watch(app_files.index, ['index']);
});

gulp.task('build', function() {
  runSequence('clean',
    'templates',
    ['styles', 'compile', 'vendors', 'assets'],
    'index');
});

gulp.task('default', function() {
  runSequence('build',
    ['watch', 'karma-autowatch']);
});