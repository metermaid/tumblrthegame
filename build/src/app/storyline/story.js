(function(){var e,t,o,a,s;o=["ui.router","common.directives","common.tags","common.user_storage","rounds.services","cfp.hotkeys","cfp.hotkeys","rounds.services"],a=angular.module("tumblrGame.storyline",o),s=function(e){return e.state("story",{params:["type","category"],views:{header:{controller:"HeaderCtrl",templateUrl:"rounds/views/header.tpl.html"},main:{controller:"StoryCtrl",templateUrl:"storyline/story.tpl.html"}},data:{pageTitle:"Round Start"}})},s.$inject=["$stateProvider"],a.config(s),t=function(){function e(e,t,o,a,s,n,r,i,u,l){var c,m,h;e.round=s.get("current_round"),e.storyline=a.get_story(e.round,i.type),e.category=i.category||"tv series",h=t.random_tag_index(e.category),m=t.tag(e.category,h),c=o.fromPastMonths(12),e.posts=[],n.jsonp_query({tag:m.name,before:c},function(t){var o,a,s,n,r;for(e.message=t.meta,r=t.response,s=0,n=r.length;n>s&&(a=r[s],!("photo"===a.type&&(e.posts.push(a),e.posts.length>=6)));s++);return o=e.posts.map(function(e){return e.photos[0].alt_sizes[1].url}),l.preloadImages(o).then(function(){return e.isLoading=!1,e.isSuccessful=!0,console.info("Preload Successful")},function(t){return e.isLoading=!1,e.isSuccessful=!1,console.error("Image Failed",t),console.info("Preload Failure")},function(t){return e.percentLoaded=t.percent,console.info("Percent loaded:",t.percent)})}),e.dialogID=0,e.next=function(){return e.dialogID<e.storyline.length-1?e.dialogID=e.dialogID+1:r.transitionTo("round",{category:i.category,index:h,before:c})},u.bindTo(e).add({combo:"enter",description:"Next",callback:e.next})}return e.$inject=["$scope","TagsService","RandomDateService","StoryService","gameStorage","RoundsRes","$state","$stateParams","hotkeys","imagePreloader"],e}(),a.controller("StoryCtrl",t),e=function(){function e(e,t,o,a){this.content=e,this.type=null!=t?t:"modal",this.speaker=o,this.button=a}return e}(),a.service("StoryService",function(){var t,o,a;return t={"1_start":[new e("You're a bit confused by the premise of this test, so you message your mentor."),new e("Kcklqkla, if this test is pulling the latest posts from Tumblr, what guarantee is there that the posts would make sense in the context of the test? Humans sometimes tag things incorrectly.","message U","you"),new e("Oh, there's no guarantee. Sometimes it's gibberish. Sometimes it's human pornography. Have fun.","message K","kcklqkla"),new e("That was discouraging. The High Council is a cruel organization.")],"2_start":[new e("Your friend Becky messages you before this round."),new e("omg, i bet you cant beat my hi score of 250!! ur such a loser","message B","becky"),new e("She's kinda mean. Why are you friends with Becky again?")],"3_start":[new e("You receive a message from Kcklqkla before this latest round."),new e("Hey, did you know that you can use keyboard shortcuts in this game? Just hit enter at most screens, and then in the round selection page you can use alt/option + (1,2,3,4).","message K","kcklqkla"),new e("Ugh, why didn't she tell you this sooner?")],"7_start":[new e("hey loser have u gotten 250 yet, i bet u havent","message B","becky")],"12_start":[new e("r u still not at 250 looool","message B","becky")]},o={start:[[new e("Your mentor offers you words of encouragement."),new e("Even if you fail your studies, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.","message K","kcklqkla"),new e("You do not find this encouraging.")],[new e("Your mentor offers you words of encouragement."),new e("Hey, if you're lazy, you can always study to be a Juggalo!","message K","kcklqkla"),new e("You do not find this encouraging.")],[new e("Hey, what do you want your human persona to be? The High Council is asking.","message K","kcklqkla"),new e("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.","message U","you"),new e("... I'm going to put you down as a 20-something male then.","message K","kcklqkla")],[new e("hey what will ur human persona be","message B","becky"),new e("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.","message U","you"),new e("YOUR DELUSIONAL. EVERYBODY KNOWS YOU CANT TIE DOWN PINKIE PIE LIKE THAT.","message B","becky")],[new e("You think your mentor, Kcklqkla, is acting especially awkward around you. You suspect that they have read your smutty fanfics.")],[new e("You receive another message from your friend Becky."),new e("at this rate you'll never get to earth... #earthlings... #thatcouldbeusbutuplayin","message B","becky"),new e("I don't think Becky understands hashtags.")],[new e("You feel extremely nervous about this test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")],[new e("hey loser i just got into this band u prolly never heard of em","message B","becky"),new e("Uh, what band?","message U","you"),new e("their called one direction they are sooooooo cuteee","message B","becky"),new e("Becky always has impeccable taste. You're jealous.")],[new e("Try practicing your best impression of a cool human to me.","message K","kcklqkla"),new e("Oh, well, I just started listening to the COOLEST podcast--","message U","you"),new e("You must be mistaken. I said cool. Cool in the Humanese English language doesn't mean loser.","message K","kcklqkla")],[new e("I think I'm going to be one of those food bloggers when I'm undercover as a human. But I mean, never making anything though. Just one of those humans that just reblogs photos of pizza.","message U","you")],[new e("What will your human persona's aspirations be?","message K","kcklqkla"),new e("I think I wanna be a really famous gifset maker.","message U","you"),new e("I meant career goals.","message K","kcklqkla"),new e("Career? In this economy?","message U","you"),new e("Kcklqkla seems impressed by your ad-lib. Just like a real human!")],[new e("Oh man, Becky, did you see the latest--","message U","you"),new e("STOP! SPOILERS!","message B","becky"),new e("I didn't even finish!","message U","you"),new e("UGH JUST SAYING THE TITLE OF WHATEVER U WERE GONNA SAY IS A SPOILER","message B","becky")],[new e("Becky and you are practicing talking about video games under the watchful eye of Kcklqkla."),new e("ugh i hate her she's the worst","message B","becky"),new e("Becky, I'm pretty sure that your interpretation is based purely on the popularized fanon version of the character. i'm sure you'd feel differently if you go back to the original Japanese version.","message U","you"),new e("That was a pretty impressive ad-lib. Well done.")]]},a={get_story:function(e,a){var s,n;return""+e+"_"+a in t?n=t[""+e+"_"+a]:(s=o[a],n=s[Math.floor(Math.random()*s.length)]),n}}})}).call(this);