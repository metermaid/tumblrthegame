class Alias
  constructor: (names) ->
    @names = names
  name: -> @names[0]
  aliases: -> @names

# tags are represented as a set of regular expressions
all_tags = {
  'TV series': [
    {"name": "adventure time", "regex" : /^#?(adventure ?time)|(adventure time with finn and jake)$/i},
    {"name": "supernatural", "regex" : /^#?supernatural$/i},
    {"name": "doctor who", "regex" : /^#?(doctor ?who)|(dw)|(timey ?wimey)$/i},
    {"name": "sherlock", "regex" : /^#?sherlock$/i},
    {"name": "community", "regex" : /^#?community$/i},
    {"name": "parks and recreation", "regex" : /^#parks ?(and|&|\+) ? rec(reation)?$/i},
    {"name" : "lord of the rings", "regex" : /^#?(lotr)|(lord ?of ?the ?rings)|(potatoes)$/i},
    {"name" : "harry potter" , "regex" :/^#?(harry ?potter)$/i} ],
  'characters': [
    {"name" : "hannibal lecter", "regex" : /^#?hannibal ?(lecter)?$/i},
    {"name" : "mako mori" , "regex" : /^#?mako ?mori$/i},
    {"name" : "katniss everdeen", "regex" : /^#?katniss ?(everdeen)?$/i} ],
  'marvel': [
    {"name": "spiderman", "regex": /^#?spiderman|(peter ?parker)$/i},
    {"name": "avengers", "regex": /^#?avengers$/i},
    {"name": "iron man", "regex": /^#?iron ?man$/i},
    {"name": "doctor strange", "regex": /^#?(doctor)|(dr) ?strange$/i},
    {"name": "hulk", "regex": /^#?hulk$/i},
    {"name": "captain america", "regex": /^#?captain ?(america)|(handsome)$/i},
    {"name": "fantastic four", "regex": /^#?fantastic ?four$/i}
  ],
  'cartoons': [
    {"name": "adventure time", "regex" : /^#?(adventure ?time)|(adventure time with finn and jake)$/i},
    {"name": "my little pony", "regex": /^#?my ?little ?pony$/i},
    {"name": "gravity falls", "regex": /^#?gravity ?falls$/i},
    {"name": "powerpuff girls", "regex": /^#?powerpuff ?girls$/i},
    {"name": "the last airbender", "regex": /^#?(the ?last ?airbender)|avatar$/i},
    {"name": "steven universe", "regex": /^#?steven ?universe$/i}
  ],
  'homestuck': [
    {"name": "dave strider", "regex": /^#?dave ?strider$/i},
    {"name": "roxy lalonde", "regex": /^#?roxy ?lalonde$/i},
    {"name": "nepeta", "regex": /^#?nepeta$/i},
    {"name": "john egbert", "regex": /^#?john ?egbert$/i},
    {"name": "vriska serket", "regex": /^#?vriska$/i},
    {"name": "tavros nitram", "regex": /^#?tavros$/i},
    {"name": "terezi", "regex": /^#?terezi$/i},
    {"name": "equius", "regex": /^#?equius$/i}
  ],
  'disney princesses': [
    {"name": "snow white", "regex": /^#?snow ?white$/i},
    {"name": "jasmine", "regex": /^#?jasmine$/i},
    {"name": "cinderella", "regex": /^#?cinderella$/i},
    {"name": "ariel", "regex": /^#?ariel$/i},
    {"name": "belle", "regex": /^#?belle$/i},
    {"name": "pocahontas", "regex": /^#?pocahontas$/i},
    {"name": "mulan", "regex": /^#?mulan$/i},
    {"name": "tiana", "regex": /^#?tiana$/i},
    {"name": "rapunzel", "regex": /^#?rapunzel$/i},
    {"name": "merida", "regex": /^#?merida$/i}
  ],
  'dog breeds': [
    {"name": "corgis", "regex": /^#?corgis?$/i},
    {"name": "pomeranians", "regex": /^#?pemeranians?$/i},
    {"name": "beagles", "regex": /^#?beagles$/i},
    {"name": "shiba inu", "regex": /^#?shiba ?inu$/i},
    {"name": "greyhounds", "regex": /^#?greyhounds?$/i},
    {"name": "huskies", "regex": /^#?(huskies)|husky$/i},
    {"name": "chihuahuas", "regex": /^#?chihuahuas?$/i},
    {"name": "bulldogs", "regex": /^#?bulldogs?$/i}
  ],
  'anime': [
    {"name": "cowboy bebop", "regex": /^#?(cowboy ?bebop)$/i},
    {"name": "space dandy", "regex": /^#?space ?dandy$/i},
    {"name": "kill la kill", "regex": /^#?kill ?la ?kill$/i},
    {"name": "sailor moon", "regex": /^#?sailor ?moon$/i},
    {"name": "attack on titan", "regex": /^#?attack ?on ?titan$/i}
  ]
    # template: {"name": "", "regex": /^#?$/i}
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
