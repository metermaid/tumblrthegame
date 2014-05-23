require('coffee-script/register');

// myConf.js
exports.config = {
  seleniumServerJar: './node_modules/protractor/selenium/selenium-server-standalone-2.41.0.jar', // Make sure you check the version in the folder
  specs: [ 'src/**/*.scenario.coffee' ],
  capabilities: {
    'browserName': 'chrome'
  },
  baseUrl: 'http://localhost:8001',

  // Options to be passed to Jasmine-node.
  jasmineNodeOpts: {
    showColors: true,
    defaultTimeoutInterval: 30000
  }
}