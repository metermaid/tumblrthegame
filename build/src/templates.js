!function(t){try{t=angular.module("templates")}catch(e){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("home/home.tpl.html",'<a ng-click="play()" ng-class="{active:$uiRoute}" class="button start">\n   <i class="icon-play"></i>Start the Game\n</a>')}])}(),function(t){try{t=angular.module("templates")}catch(e){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/end.tpl.html",'<h2>{{winMessage}}</h2>\n<p>\n   <img src="{{gif}}"><br />\n   <a ng-click="play()" class="button start">\n      <i class="icon-play"></i>Next Round\n   </a>\n</p>\n<div class="post rebloggable" ng-repeat="post in posts  | filter:{ type : \'photo\' } | limitTo: 6">\n	<img src="{{post.photos[0].original_size.url}}" width="50%" />\n   <div class="post_controls">\n      <a href="http://www.tumblr.com/reblog/{{post.id}}/{{post.reblog_key}}" target="_blank"><i class="icon-retweet"></i>Reblog</a>\n   </div>\n</div>\n')}])}(),function(t){try{t=angular.module("templates")}catch(e){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/header.tpl.html",'<h1>tumblr. the game.</h1>\n<nav ng-hide="end">\n<h2>ROUND {{round}}</h2>\n</nav>\n<nav ng-show="end">\n<h2>ROUND {{round-1}}</h2>\n</nav>')}])}(),function(t){try{t=angular.module("templates")}catch(e){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/round.tpl.html",'<h2>What tag is this?</h2>\n<h3>You have {{secondsLeft}} to guess!</h3>\n<input type="text" id="guess" ng-model="guess" focus="true">\n<h1 ng-show="correct">Correct?!</h1>\n<div class="post" ng-repeat="post in posts  | filter:{ type : \'photo\' } | limitTo: 6">\n	<img src="{{post.photos[0].original_size.url}}" />\n</div>\n')}])}(),function(t){try{t=angular.module("templates")}catch(e){t=angular.module("templates",[])}t.run(["$templateCache",function(t){t.put("rounds/views/select.tpl.html",'<h2>Select a Category</h2>\n<div ng-repeat="category in categories">\n   <a ng-click="play(category)" class="button category">\n	  {{category}}\n   </a>\n</div>')}])}();