tags = angular.module "common.tags", []

# tags are represented as a set of regular expressions
tags.constant "allTags", {
  'TV series': [
    {"name": "adventure time", "regex" : /adventure ?time/},
    {"name": "supernatural", "regex" : /supernatural/},
    {"name": "doctor who", "regex" : /(doctor|dr.?) ?who|dw|timey ?wimey/},
    {"name": "sherlock", "regex" : /sherlock/},
    {"name": "nbc community", "regex" : /community/},
    {"name": "parks and recreation", "regex" : /parks ?(and|&|\+) ?rec(reation)?/}],
  'female protagonists': [
    {"name" : "Lisbeth Salander", "regex" : /Lisbeth ?Salander|(the)? ?girl ?with ?the ?dragon ?tattoo/},
    {"name" : "ellen ripley" , "regex" : /(ellen ?ripley)|ripley/},
    {"name" : "mako mori" , "regex" : /mako ?mori/},
    {"name" : "dorothy gale" , "regex" : /dorothy/},
    {"name" : "princess leia" , "regex" : /princess ?leia|leia/},
    {"name" : "mary poppins" , "regex" : /mary ?poppins/},
    {"name" : "sarah connor" , "regex" : /sarah ?connor/},
    {"name" : "katniss everdeen", "regex" : /katniss ?(everdeen)?/} ],
  'marvel': [
    {"name": "spiderman", "regex": /spiderman|(peter ?parker)/},
    {"name": "avengers", "regex": /avengers/},
    {"name": "iron man", "regex": /iron ?man/},
    {"name": "doctor strange", "regex": /(doctor|dr.?) ?strange/},
    {"name": "hulk", "regex": /hulk/},
    {"name": "captain america", "regex": /captain ?(america|handsome)/},
    {"name": "fantastic four", "regex": /fantastic ?(four|4)|f4|ff/}
  ],
  'harry potter': [
    {"name": "harry potter", "regex" : /harry ?potter/},
    {"name": "draco malfoy", "regex": /draco ?malfoy/},
    {"name": "cho chang", "regex": /cho ?chang/},
    {"name": "hermione granger", "regex": /hermione ?granger/},
    {"name": "ron weasley", "regex": /ron ?weasley/},
    {"name": "dumbledore", "regex": /dumbledore/},
    {"name": "sirius black", "regex": /sirius ?black/},
    {"name": "the marauders", "regex": /(the ?)?marauders/},
    {"name": "dementors", "regex": /dementors?/},
    {"name": "hagrid", "regex": /hagrid/}
  ],
  'cartoons': [
    {"name": "adventure time", "regex" : /adventure ?time/},
    {"name": "my little pony", "regex": /my ?little ?pony/},
    {"name": "gravity falls", "regex": /gravity ?falls/},
    {"name": "powerpuff girls", "regex": /powerpuff ?girls/},
    {"name": "the last airbender", "regex": /(the ?last ?airbender)|avatar/},
    {"name": "steven universe", "regex": /steven ?universe/},
    {"name": "dexters laboratory", "regex": /dexter'?s ?lab/}
  ],
  'mecha': [
    {"name": "Gurren Lagann", "regex": /Gurren ?Lagann/},
    {"name": "Evangelion", "regex": /Evangelion/},
    {"name": "Mazinger Z", "regex": /Mazinger ?Z/},
    {"name": "Full Metal Panic", "regex": /Full ?Metal ?Panic|fmp/},
    {"name": "Gundam", "regex": /Gundam/},

    {"name": "Nadesico", "regex": /Nadesico/},
    {"name": "Macross", "regex": /Macross/},
    {"name": "Gunbuster", "regex": /Gunbuster/},
    {"name": "Rahxephon", "regex": /Rahxephon/},
    {"name": "Escaflowne", "regex": /Escaflowne/},
    {"name": "Code Geass", "regex": /Code ?Geass/},
    {"name": "Patlabor", "regex": /Patlabor/},
    {"name": "Eureka 7", "regex": /Eureka ?7/}
  ],
  'movies' : [
    {"name" : "lord of the rings", "regex" : /(lotr)|(lord ?of ?the ?rings)|(potatoes)/},
    {"name" : "hunger games", "regex" : /((the ?)?hunger ?games)|(thg)/},
    {"name" : "harry potter" , "regex" :/(harry ?potter)/},
    {"name" : "star wars" , "regex" :/(star ?wars)/},
    {"name": "pacific rim", "regex" : /pacific ?rim/},
    {"name": "indiana jones", "regex" : /indiana ?jones/},
    {"name": "the matrix", "regex" : /the ?matrix/},
    {"name": "die hard", "regex" : /die ?hard/},
    {"name": "pulp fiction", "regex" : /pulp ?fiction/},
    {"name": "kill bill", "regex" : /kill ?bill/},
    {"name": "austin powers", "regex" : /austin ?powers/},
    {"name": "jurassic park", "regex" : /jurassic ?park/},
    {"name": "rushmore", "regex" : /rushmore/},
    {"name": "shrek", "regex" : /shrek/},
    {"name": "the royal tenenbaums", "regex" : /(the)? ?royal ?tenenbaums/},
    {"name": "the hunger games", "regex" : /((the ?)?hunger ?games)|(thg)/},
    {"name": "pitch perfect", "regex" : /pitch ?perfect/},
    {"name": "toy story", "regex" : /toy ?story/},
    {"name": "james bond", "regex" : /james ?bond/},
    {"name": "the dark knight", "regex" : /(the)? ?dark ?knight|batman/}
  ],
  'video games' : [
    {"name": "harvest moon", "regex" : /harvest ?moon/},
    {"name": "street fighter", "regex" : /street ?fighter/},
    {"name": "final fantasy vii", "regex" : /final ?fantasy ?((vii)|(7))/},
    {"name": "final fantasy vi", "regex" : /final ?fantasy ?(vi|6|iii|3)/},
    {"name": "final fantasy iv", "regex" : /final ?fantasy ?(iv|4|ii|2)/},
    {"name": "chrono trigger", "regex" : /chrono ?trigger/},
    {"name": "super smash bros", "regex" : /(super)? ?smash ?bros/},
    {"name": "super mario", "regex" : /(super)? ?mario/},
    {"name": "fire emblem", "regex" : /fire ?emblem/},
    {"name": "legend of zelda", "regex" : /(the)? ?(legend ?of)? ?zelda/},
    {"name": "galaga", "regex" : /galaga/},
    {"name": "persona", "regex" : /persona|(shin ?megami ?tensei)/},
    {"name": "fire emblem", "regex" : /fire ?emblem/},
    {"name": "metal gear solid", "regex" : /metal ?gear ?solid/},
    {"name": "tomodachi life", "regex" : /tomodachi ?life/},
    {"name": "mario kart", "regex" : /mario ?kart/},
    # {"name": "love plus", "regex" : /love ?plus/},
    {"name": "flappy bird", "regex" : /flappy ?bird/},
    {"name": "halo", "regex" : /halo/}
  ],
  'homestuck': [
    {"name": "john egbert", "regex": /john/},
    {"name": "dave strider", "regex": /dave/},
    {"name": "rose lalonde", "regex": /rose/},
    {"name": "jade harley", "regex": /jade/},
    {"name": "jane crocker", "regex": /jane/},
    {"name": "roxy lalonde", "regex": /roxy/},
    {"name": "dirk strider", "regex": /dirk/},
    {"name": "jake english", "regex": /jake/},
    {"name": "karkat", "regex": /karkat/},
    {"name": "gamzee", "regex": /gamzee/},
    {"name": "terezi", "regex": /terezi/},
    {"name": "sollux", "regex": /sollux/},
    {"name": "tavros nitram", "regex": /tavros/},
    {"name": "aradia", "regex": /aradia/},
    {"name": "nepeta", "regex": /nepeta/},
    {"name": "vriska serket", "regex": /vriska/},
    {"name": "equius", "regex": /equius/},
    {"name": "kanaya", "regex": /kanaya/},
    {"name": "eridan", "regex": /eridan/},
    {"name": "feferi", "regex": /feferi/}
  ],
  'disney princesses': [
    {"name": "snow white", "regex": /snow ?white/},
    {"name": "jasmine", "regex": /jasmine/},
    {"name": "cinderella", "regex": /cinderella/},
    {"name": "ariel", "regex": /ariel/},
    {"name": "belle", "regex": /belle/},
    {"name": "pocahontas", "regex": /pocahontas/},
    {"name": "mulan", "regex": /mulan/},
    {"name": "tiana", "regex": /tiana/},
    {"name": "rapunzel", "regex": /rapunzel/},
    {"name": "merida", "regex": /merida/}
  ],
  'dog breeds': [
    {"name": "corgis", "regex": /corgi/},
    {"name": "pomeranians", "regex": /pomeranian/},
    {"name": "beagles", "regex": /beagle/},
    {"name": "shiba inu", "regex": /shiba ?inu/},
    {"name": "greyhounds", "regex": /greyhound/},
    {"name": "huskies", "regex": /(huskies)|husky/},
    {"name": "chihuahuas", "regex": /chihuahua/},
    {"name": "bulldogs", "regex": /bulldog/}
  ],
  'anime': [
    {"name": "cowboy bebop", "regex": /(cowboy ?bebop)/},
    {"name": "space dandy", "regex": /space ?dandy/},
    {"name": "kill la kill", "regex": /kill ?la ?kill/},
    {"name": "sailor moon", "regex": /sailor ?moon/},
    {"name": "naruto", "regex": /naruto/},
    {"name": "one piece", "regex": /one ?piece/},
    {"name": "attack on titan", "regex": /(attack ?on ?titan)|(snk)|(shingeki ?no ?kyojin)/}
  ],
  'Famous Landmarks': [
    {"name": "big ben", "regex": /big ?ben|clock ?tower|elizabeth ?tower/},
    {"name": "eiffel tower", "regex": /eiffel ?tower/},
    {"name": "empire state building", "regex": /empire ?state ?building/},
    {"name": "washington memorial", "regex": /washington ?memorial/},
    {"name": "great pyramids", "regex": /great ?pyramids/},
    {"name": "taj mahal", "regex": /taj ?mahal/},
    {"name": "stonehenge", "regex": /stonehenge/},
    {"name": "great wall", "regex": /great ?wall/},
    {"name": "angkor wat", "regex": /angkor ?wat/},
    {"name": "acropolis", "regex": /acropolis/},
    {"name": "statue of liberty", "regex": /statue ?of ?liberty/}
  ],
  'Food Porn': [
    {"name": "spaghetti", "regex": /spaghetti/},
    {"name": "burger", "regex": /burger/},
    {"name": "fries", "regex": /(french ?)?fries/},
    {"name": "ramen", "regex": /ramen/},
    {"name": "sushi", "regex": /sushi/},
    {"name": "salad", "regex": /salad/}, # IS THIS EVEN FOOD PORN? I DON'T THINK SO.
    {"name": "pizza", "regex": /pizza/},
    {"name": "steak", "regex": /steak/},
    {"name": "bacon", "regex": /bacon/},
    {"name": "taco", "regex": /taco/},
    {"name": "dim sum", "regex": /dim ?sum|yum ?cha/},
    {"name": "fried rice", "regex": /fried ?rice/},
    {"name": "paella", "regex": /paella/},
    {"name": "crepes", "regex": /crepes?/},
    {"name": "tempura", "regex": /tempura/},
    {"name": "falafel", "regex": /falafel/}
  ],
  'Pop Stars': [
    {"name": "lady gaga", "regex": /lady ?gaga/},
    {"name": "britney spears", "regex": /britney/},
    {"name": "michael jackson", "regex": /michael ?jackson/},
    {"name": "prince", "regex": /prince/},
    {"name": "the bee gees", "regex": /(the ?)?bee ?gees/},
    {"name": "abba", "regex": /abba/},
    {"name": "the beach boys", "regex": /(the ?)?beach ?boys/},
    {"name": "stevie wonder", "regex": /stevie ?wonder/},
    {"name": "mariah carey", "regex": /mariah ?carey/},
    {"name": "elton john", "regex": /elton ?john/},
    {"name": "beyonce", "regex": /beyonce/},
    {"name": "rihanna", "regex": /rihanna/},
    {"name": "spice girls", "regex": /spice ?girls/},
    {"name": "whitney houston", "regex": /whitney ?houston/}
  ],
  'NHL Teams': [
    {"name": "chicago blackhawks", "regex": /(chicago ?)?blackhawks?/},
    {"name": "montreal canadiens", "regex": /(montreal ?)?canadiens?/},
    {"name": "la kings", "regex": /(l.?a.?|los ?angeles)? ?kings?/},
    {"name": "anaheim ducks", "regex": /(anaheim ?)?ducks?|(the ?)?mighty ?ducks/},
    {"name": "boston bruins", "regex": /(boston ?)?bruins?/},
    {"name": "vancouver canucks", "regex": /(vancouver ?)?canucks?/},
    {"name": "pittsburgh penguins", "regex": /(pittsburgh ?)?penguins?/},
    {"name": "new york rangers", "regex": /(new ?york ?)?rangers?/}
  ],
  'Rappers': [
    {"name": "nicki minaj", "regex": /nicki ?minaj/},
    {"name": "kanye west", "regex": /kanye|yeezy/},
    {"name": "drake", "regex": /drake/},
    {"name": "kendrick lamar", "regex": /kendrick ?lamar/},
    {"name": "eminem", "regex": /eminem/},
    {"name": "lil wayne", "regex": /lil ?wayne|weezy/},
    {"name": "jay z", "regex": /jay ?z|hova/},
    {"name": "rick ross", "regex": /rick ?ross/},
    {"name": "tupac", "regex": /tupac|2pac/},
    {"name": "chief keef", "regex": /chief keef/},
    {"name": "snoop dogg", "regex": /snoop/}
  ]
    # template: {"name": "", "regex": //}
}

tags.service "TagsService", ['allTags', (allTags) ->
  random_categories: (length) ->
    categories = Object.keys(allTags)
    # From the end of the list to the beginning, pick element `i`.
    for i in [categories.length-1..1]
      # Choose random element `j` to the front of `i` to swap with.
      j = Math.floor Math.random() * (i + 1)
      # Swap `j` with `i`, using destructured assignment
      [categories[i], categories[j]] = [categories[j], categories[i]]
    # Return the shuffled array.
    categories.slice(0,length)
  random_tag_index: (type) ->
    tags = allTags[type]
    return Math.floor(Math.random() * tags.length)
  tag: (type, index) ->
    tags = allTags[type]
    return tags[index]
  random_tag: (type) ->
    tags = allTags[type]
    return tags[Math.floor(Math.random() * tags.length)]
]