(function(){var e,a;a=angular.module("story.services",[]),e=function(){function e(e,a,t,s){this.content=e,this.type=null!=a?a:"modal",this.speaker=t,this.button=s}return e}(),window.Dialog=e,a.constant("check_points",{"1_start":[new e("You're a bit confused by the premise of this test, so you message your mentor."),new e("Kcklqkla, if this test is pulling the latest posts from Tumblr, what guarantee is there that the posts would make sense in the context of the test? Humans sometimes tag things incorrectly.","message U","you"),new e("Oh, there's no guarantee. Sometimes it's gibberish. Sometimes it's human pornography. Have fun.","message K","kcklqkla"),new e("That was discouraging. The High Council is a cruel organization.")],"2_start":[new e("Your friend Becky messages you before this round."),new e("omg, i bet you cant beat my hi score of 250!! ur such a loser","message B","becky"),new e("She's kinda mean. Why are you friends with Becky again?")],"5_start":[new e("hey loser have u gotten 250 yet, i bet u havent","message B","becky")],"10_start":[new e("r u still not at 250 looool","message B","becky")]}),a.constant("random_chapters",{start:[[new e("Your mentor offers you words of encouragement."),new e("Even if you fail your studies, maybe you can still be part of the mission to join the earth. You can just be a very stupid human.","message K","kcklqkla"),new e("You do not find this encouraging.")],[new e("Your mentor offers you words of encouragement."),new e("Hey, if you're lazy, you can always study to be a Juggalo!","message K","kcklqkla"),new e("You do not find this encouraging.")],[new e("Hey, what do you want your human persona to be? The High Council is asking.","message K","kcklqkla"),new e("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.","message U","you"),new e("... I'm going to put you down as a 20-something male then.","message K","kcklqkla")],[new e("hey what will ur human persona be","message B","becky"),new e("Whatever I am, I'm pretty sure my soul will be that of a majestic but modest stallion in a deep and committed relationship with a filly named Pinkie Pie.","message U","you"),new e("YOUR DELUSIONAL. EVERYBODY KNOWS YOU CANT TIE DOWN PINKIE PIE LIKE THAT.","message B","becky")],[new e("You think your mentor, Kcklqkla, is acting especially awkward around you. You suspect that they have read your smutty fanfics.")],[new e("You receive another message from your friend Becky."),new e("at this rate you'll never get to earth... #earthlings... #thatcouldbeusbutuplayin","message B","becky"),new e("I don't think Becky understands hashtags.")],[new e("You feel extremely nervous about this test. What if you confuse Teen Wolf for Supernatural? You'd be mortified.")],[new e("hey loser i just got into this band u prolly never heard of em","message B","becky"),new e("Uh, what band?","message U","you"),new e("their called one direction they are sooooooo cuteee","message B","becky"),new e("Becky always has impeccable taste. You're jealous.")],[new e("Try practicing your best impression of a cool human to me.","message K","kcklqkla"),new e("Oh, well, I just started listening to the COOLEST podcast--","message U","you"),new e("You must be mistaken. I said cool. Cool in the Humanese English language doesn't mean loser.","message K","kcklqkla")],[new e("I think I'm going to be one of those food bloggers when I'm undercover as a human. But I mean, never making anything though. Just one of those humans that just reblogs photos of pizza.","message U","you")],[new e("What will your human persona's aspirations be?","message K","kcklqkla"),new e("I think I wanna be a really famous gifset maker.","message U","you"),new e("I meant career goals.","message K","kcklqkla"),new e("Career? In this economy?","message U","you"),new e("Kcklqkla seems impressed by your ad-lib. Just like a real human!")],[new e("Oh man, Becky, did you see the latest--","message U","you"),new e("STOP! SPOILERS!","message B","becky"),new e("I didn't even finish!","message U","you"),new e("UGH JUST SAYING THE TITLE OF WHATEVER U WERE GONNA SAY IS A SPOILER","message B","becky")],[new e("Becky and you are practicing talking about video games under the watchful eye of Kcklqkla."),new e("ugh i hate her she's the worst","message B","becky"),new e("Becky, I'm pretty sure that your interpretation is based purely on the popularized fanon version of the character. i'm sure you'd feel differently if you go back to the original Japanese version.","message U","you"),new e("That was a pretty impressive ad-lib. Well done.")]]}),a.service("StoryService",["check_points","random_chapters",function(e,a){var t;return t={get_story:function(t,s){var o,n;return""+t+"_"+s in e?n=e[""+t+"_"+s]:(o=a[s],n=o[Math.floor(Math.random()*o.length)]),n}}}])}).call(this);