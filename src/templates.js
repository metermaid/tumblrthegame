!function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("home/home.tpl.html",'<div class="intro">\n<p>You are an alien spy preparing for your biggest assignment yet: infiltrating the planet Earth.</p>\n<p>To prepare you for this mission, you must study the Earth\'s culture. The High Council of Spycraft has given you access to its greatest study aid: the website, Tumblr&reg;. Young Earthlings, they say, spend their time trading pictures of their genitals and reblogging pictures on Tumblr&reg;.</p>\n<p><strong>Your mission: blend in with these tumbling Earthlings. Your test: to successfully recognize and report the common tag for each set of images.</strong></p>\n<p><strong>Correct answers will automatically be submitted. Incorrect answers will be ignored.</strong></p>\n<p><strong>The test begins now.</strong></p>\n</div>\n<a ng-click="play()" class="button start">\n   <i class="icon-play"></i>Start the Game\n</a>\n<div class="caption">Hit Space to Continue</div>\n<a href="https://github.com/metermaid/tumblrthegame"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/365986a132ccd6a44c23a9169022c0b5c890c387/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_red_aa0000.png"></a>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("storyline/story.tpl.html",'<div class="story">\n   <div class="container" ng-repeat="dialog in storyline" ng-show="dialogID==$index">\n      <div class="icon" ng-class="dialog.type" ng-show="dialog.type.lastIndexOf(\'message\', 0) === 0"></div>\n      <div class="dialog" ng-class="dialog.type">\n\n        <div class="credit" ng-show="dialog.speaker != \'\'">\n          {{dialog.speaker}}\n        </div>\n         <div>\n            {{dialog.content}}\n         </div>\n      </div>\n   </div>\n   <a ng-click="next()" type="button" class="button">\n       <i class="icon-play"></i>Next\n   </a>\n   <div class="caption">Hit Space to Continue, Enter to Skip</div>\n</div>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/end.tpl.html",'<h2>{{message}}</h2>\n<div>\n   <a ng-click="play()" class="button start">\n      <i class="icon-play"></i>Next Round\n   </a>\n   <div class="caption">Hit Space to Continue</div>\n</div>\n<div class="post rebloggable" ng-repeat="post in posts">\n	<img ng-src="{{post.photos[0].alt_sizes[1].url}}" width="50%" />\n   <div class="post_controls">\n      <a href="http://www.tumblr.com/reblog/{{post.id}}/{{post.reblog_key}}" target="_blank"><i class="icon-retweet"></i>Reblog</a>\n      <a href="{{post.post_url}}" target="_blank"><i class="icon-link"></i>View</a>\n   </div>\n</div>\n')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/header.tpl.html",'<h1 ng-click="info = !info">tumblr. the game.<a class="info">info</a></h1>\n<div class="info tooltip" ng-show="info">\n   <h3>about</h3>\n   <p>tumblr the game is a pop culture game wherein you guess the common tag for a set of images.</p>\n   <p>As all images are sourced from the latest posts on tumblr, we are not responsible for the contents of each game. We are sorry for any duplicate images, or any unrelated images, and especially sorry if any pornography shows up.</p>\n   <p>Try to get a high score, and share with your friends!</p>\n   <p><a href="https://docs.google.com/forms/d/17LO23cdV_pwOg1hM2KjXv97uBfVqMtuc_IkY75lm9NI/viewform" target="_blank">Send us feedback</a></p>\n   <h3>credits</h3>\n   <p>tumblr the game was created by <a href="http://www.jynx.ca" target="_blank">Rita</a> and <a href="http://danamongrobots.tumblr.com" target="_blank">Daniel</a>. Follow them on Tumblr!</p>\n   <p>This application uses the Tumblr application programming interface but is not endorsed or certified by Tumblr, Inc. All of the Tumblr logos and trademarks displayed on this application are the property of Tumblr, Inc.</p>\n   <a ng-click="info = !info" class="button start">\n      Close\n   </a>\n</div>\n<nav>\n<h2>ROUND {{round}}</h2>\n<h2>SCORE {{score}}</h2>\n<h2>LIVES {{lives}}</h2>\n</nav>\n')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/lose.tpl.html",'<h2>You lost! :\'(</h2>\n<p>You played {{round}} rounds and got a score of {{score}}</p>\n<a ng-click="returnToHome()" class="button category">Play again</a>\n<p />\n<div>\n  <a class="button social" title="Share on Tumblr" href="http://www.tumblr.com/share/link?url=tumblr.ceiling.cat&name=tumblr.%20the%20game.&description=I%20got%20a%20score%20of%20{{score}}%20studying%20the%20humans%20through%20the%20hashtags.%20How%20well%20will%20you%20do%3F%20Find%20out!">\n  <i class="icon-tumblr"></i>Share Score on Tumblr\n  </a>\n</div>\n<p />\n<div>\n  <a class="button social" target="_blank" title="Tweet Score" href="https://twitter.com/share?text=On%20http%3A%2F%2Ftumblr.ceiling.cat%20I%20got%20a%20score%20of%20{{score}}%20studying%20the%20humans%20through%20%23tumblr.%20How%20well%20will%20you%20do%3F%20Find%20out!%20%23tumblrthegame">\n  <i class="icon-twitter"></i>Tweet Score\n  </a>\n</div>\n')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/round.tpl.html",'<div ng-switch="isLoading">\n\n   <!-- BEGIN: Loading View. -->\n   <p ng-switch-when="true">\n\n      Stage is loading... {{ percentLoaded }}%\n\n   </p>\n   <!-- END: Loading View. -->\n\n   <!-- BEGIN: Results View. -->\n   <div\n      ng-switch-when="false">\n      <div ng-switch="status">\n         <h3>What {{category}} tag is this?</h3>\n         <div ng-switch-when="won">\n            <h2>Correct!</h2>\n         </div>\n         <div ng-switch-when="lost">\n            <h2>Time\'s Up!</h2>\n         </div>\n         <div ng-switch-default>\n            <h2>Round ends in {{secondsLeft}}s</h2>\n         </div>\n         <input type="text" class="mousetrap" focus="true" ng-class="status" shaker id="guess" ng-model="guess" ng-disabled="status == \'won\' || status == \'lost\'" ng-change="updateGuess(guess)">\n      </div>\n      <div class="posts">\n      <div class="post" ng-repeat="post in posts">\n         <img ng-src="{{post.photos[0].alt_sizes[1].url}}" />\n      </div>\n   </div>\n   </div>\n   <!-- END: Results View. -->\n</div>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/select.tpl.html",'<h2>Select a Category</h2>\n<div ng-repeat="category in categories">\n   <a ng-click="play(category)" class="button category">\n	  {{category}}\n   </a>\n   <div class="caption">Hit alt/option + {{$index+1}}</div>\n\n</div>')}])}();