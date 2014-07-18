class Alias
  constructor: (names) ->
    @names = names
  name: -> @names[0]
  aliases: -> @names

# tags are represented as a set of regular expressions
all_tags = {
  'TV series': [
    {"name": "adventure time", "regex" : /adventure ?time/},
    {"name": "supernatural", "regex" : /supernatural/},
    {"name": "doctor who", "regex" : /(doctor ?who)|(dw)|(timey ?wimey)/},
    {"name": "sherlock", "regex" : /sherlock/},
    {"name": "community", "regex" : /community/},
    {"name": "parks and recreation", "regex" : /parks ?(and|&|\+) ? rec(reation)?/}],
  'Film series': [
    {"name" : "lord of the rings", "regex" : /(lotr)|(lord ?of ?the ?rings)|(potatoes)/},
    {"name" : "hunger games", "regex" : /((the ?)?hunger ?games)|(thg)/},
    {"name" : "harry potter" , "regex" :/(harry ?potter)/} ],
  'characters': [
    {"name" : "hannibal lecter", "regex" : /hannibal ?(lecter)?/},
    {"name" : "mako mori" , "regex" : /mako ?mori/},
    {"name" : "katniss everdeen", "regex" : /katniss ?(everdeen)?/} ],
  'marvel': [
    {"name": "spiderman", "regex": /spiderman|(peter ?parker)/},
    {"name": "avengers", "regex": /avengers/},
    {"name": "iron man", "regex": /iron ?man/},
    {"name": "doctor strange", "regex": /(doctor)|(dr) ?strange/},
    {"name": "hulk", "regex": /hulk/},
    {"name": "captain america", "regex": /captain ?(america)|(handsome)/},
    {"name": "fantastic four", "regex": /fantastic ?four/}
  ],
  'cartoons': [
    {"name": "adventure time", "regex" : /adventure ?time/},
    {"name": "my little pony", "regex": /my ?little ?pony/},
    {"name": "gravity falls", "regex": /gravity ?falls/},
    {"name": "powerpuff girls", "regex": /powerpuff ?girls/},
    {"name": "the last airbender", "regex": /(the ?last ?airbender)|avatar/},
    {"name": "steven universe", "regex": /steven ?universe/}
  ],
  'movies' : [
    {"name": "pacific rim", "regex" : /pacfic ?rim/},
    {"name": "rushmore", "regex" : /rushmore/},
    {"name": "the royal tenenbaums", "regex" : /(the)? ?royal ?tenenbaums/},
    {"name": "the hunger games", "regex" : /(the)? ?hunger ?games/},
    {"name": "pitch perfect", "regex" : /pitch ? perfect/},
    {"name": "the dark knight", "regex" : /(the)? ?dark ?knight/}
  ],
  'video games' : [
    {"name": "harvest moon", "regex" : /harvest ?moon/},
    {"name": "street fighter", "regex" : /street ?fighter/},
    {"name": "final fantasy vii", "regex" : /final ?fantasy ?((vii)|(7))/},
    {"name": "final fantasy vi", "regex" : /final ?fantasy ?((vi)|(6))/},
    {"name": "final fantasy iv", "regex" : /final ?fantasy ?((iv)|(4))/},
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
    {"name": "dave strider", "regex": /dave ?strider/},
    {"name": "roxy lalonde", "regex": /roxy ?lalonde/},
    {"name": "nepeta", "regex": /nepeta/},
    {"name": "john egbert", "regex": /john ?egbert/},
    {"name": "vriska serket", "regex": /vriska/},
    {"name": "tavros nitram", "regex": /tavros/},
    {"name": "terezi", "regex": /terezi/},
    {"name": "equius", "regex": /equius/}
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
    {"name": "attack on titan", "regex": /(attack ?on ?titan)|(snk)|(shinkegi ?no ?kyojin)/}
  ]
    # template: {"name": "", "regex": //}
}

tags = angular.module "common.tags", []

tags.service "TagsService", ->
  random_categories: (length) ->
    categories = Object.keys(all_tags)
    # From the end of the list to the beginning, pick element `i`.
    for i in [categories.length-1..1]
      # Choose random element `j` to the front of `i` to swap with.
      j = Math.floor Math.random() * (i + 1)
      # Swap `j` with `i`, using destructured assignment
      [categories[i], categories[j]] = [categories[j], categories[i]]
    # Return the shuffled array.
    categories.slice(0,length)
  random_tag: (type) ->
    tags = all_tags[type]
    return tags[Math.floor(Math.random() * tags.length)]
