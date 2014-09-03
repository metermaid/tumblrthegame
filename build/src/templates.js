!function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("home/home.tpl.html",'<div class="intro">\n<p>You are an alien spy preparing for your biggest assignment yet: infiltrating the planet Earth.</p>\n<p>To prepare you for this mission, you must study the Earth\'s culture. The High Council of Spycraft has given you access to its greatest study aid: the website, Tumblr&reg;. Young Earthlings, they say, spend their time trading pictures of their genitals and reblogging pictures on Tumblr&reg;.</p>\n<p><strong>Your mission: blend in with these tumbling Earthlings. Your test: to successfully recognize and report the common tag for each set of images.</strong></p>\n<p><strong>Correct answers will automatically be submitted. Incorrect answers will be ignored.</strong></p>\n<p><strong>The test begins now.</strong></p>\n</div>\n<a ng-click="play()" class="button start">\n   <i class="icon-play"></i>Start the Game\n</a>\n<div class="caption">Hit Space to Continue</div>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("storyline/story.tpl.html",'<div class="story">\n   <div class="container" ng-repeat="dialog in storyline" ng-show="dialogID==$index">\n      <div class="icon" ng-class="dialog.type" ng-show="dialog.type.lastIndexOf(\'message\', 0) === 0"></div>\n      <div class="dialog" ng-class="dialog.type">\n\n        <div class="credit" ng-show="dialog.speaker != \'\'">\n          {{dialog.speaker}}\n        </div>\n         <div>\n            {{dialog.content}}\n         </div>\n      </div>\n   </div>\n   <a ng-click="next()" type="button" class="button">\n       <i class="icon-play"></i>Next\n   </a>\n   <div class="caption">Hit Space to Continue, Enter to Skip</div>\n</div>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/end.tpl.html",'<h2>{{message}}</h2>\n<div>\n   <a ng-click="play()" class="button start">\n      <i class="icon-play"></i>Next Round\n   </a>\n   <div class="caption">Hit Space to Continue</div>\n</div>\n<div class="post rebloggable" ng-repeat="post in posts">\n	<img ng-src="{{post.photos[0].alt_sizes[1].url}}" width="50%" />\n   <div class="post_controls">\n      <a href="http://www.tumblr.com/reblog/{{post.id}}/{{post.reblog_key}}" target="_blank"><i class="icon-retweet"></i>Reblog</a>\n      <a href="{{post.post_url}}" target="_blank"><i class="icon-link"></i>View</a>\n   </div>\n</div>\n')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/header.tpl.html",'<h1 ng-click="info = !info">tumblr. the game.<a class="info">info</a></h1>\n<div class="info tooltip" ng-show="info">\n   <h3>about</h3>\n   <p>tumblr the game is a pop culture game wherein you guess the common tag for a set of images.</p>\n   <p>As all images are sourced from the latest posts on tumblr, we are not responsible for the contents of each game. We are sorry for any duplicate images, or any unrelated images, and especially sorry if any pornography shows up.</p> \n   <p>Try to get a high score, and share with your friends!</p>\n   <p><a href="https://docs.google.com/forms/d/17LO23cdV_pwOg1hM2KjXv97uBfVqMtuc_IkY75lm9NI/viewform" target="_blank">Send us feedback</a></p>\n   <h3>credits</h3>\n   <p>tumblr the game was created by <a href="http://danamongrobots.tumblr.com" target="_blank">Dan</a> and <a href="http://www.jynx.ca" target="_blank">Rita</a>. Follow them on Tumblr!</p>\n   <p>This application uses the Tumblr application programming interface but is not endorsed or certified by Tumblr, Inc. All of the Tumblr logos and trademarks displayed on this application are the property of Tumblr, Inc.</p>\n   <a ng-click="info = !info" class="button start">\n      Close\n   </a>\n</div>\n<nav>\n<h2>ROUND {{round}}</h2>\n<h2>SCORE {{score}}</h2>\n<h2>LIVES {{lives}}</h2>\n</nav>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/lose.tpl.html",'<h2>You lost! :\'(</h2>\n<p>You played {{round}} rounds and got a score of {{score}}</p>\n<a ng-click="shareScore()" class="button category">Share your results?</a>\n<a ng-click="returnToHome()" class="button category">Return Home</a>\n')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/round.tpl.html",'<div ng-switch="isLoading">\n\n   <!-- BEGIN: Loading View. -->\n   <p ng-switch-when="true">\n\n      Stage is loading... {{ percentLoaded }}%\n\n   </p>\n   <!-- END: Loading View. -->\n\n   <!-- BEGIN: Results View. -->\n   <div\n      ng-switch-when="false">\n      <div ng-switch="status">\n         <h3>What {{category}} tag is this?</h3>\n         <div ng-switch-when="won">\n            <h2>Correct!</h2>\n         </div>\n         <div ng-switch-when="lost">\n            <h2>Time\'s Up!</h2>\n         </div>\n         <div ng-switch-default>\n            <h2>Round ends in {{secondsLeft}}s</h2>\n         </div>\n         <input type="text" class="mousetrap" ng-class="status" shaker id="guess" ng-model="guess" ng-disabled="status == \'won\' || status == \'lost\'" ng-change="updateGuess(guess)">\n      </div>\n      <div class="posts">\n      <div class="post" ng-repeat="post in posts">\n         <img ng-src="{{post.photos[0].alt_sizes[1].url}}" />\n      </div>\n   </div>\n   </div>\n   <!-- END: Results View. -->\n</div>')}])}(),function(t){try{t=angular.module("templates")}catch(n){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/select.tpl.html",'<h2>Select a Category</h2>\n<div ng-repeat="category in categories">\n   <a ng-click="play(category)" class="button category">\n	  {{category}}\n   </a>\n   <div class="caption">Hit alt/option + {{$index+1}}</div>\n\n</div>')}])}();