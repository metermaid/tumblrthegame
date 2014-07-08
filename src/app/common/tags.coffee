class Alias
  constructor: (names) ->
    @names = names
  name: -> @names[0]
  aliases: -> @names

all_tags_big: {
    'TV series': ["adventure time", "supernatural", "doctor who", "sherlock", "community", "parks and recreation", "the big bang theory"],
    'Cartoons': ["my little pony", "adventure time", "gravity falls", "powerpuff girls", "the last airbender", "steven universe"]
    'characters': ["hannibal lecter", "mako mori", "katniss everdeen"],
    'homestuck': ['dave strider', 'roxy lalonde', 'nepeta', 'john egbert', 'vriska serket', 'tavros nitram', 'terezi', 'equius']
    'marvel': ["spiderman", "avengers", "iron man", "doctor strange", "hulk", "captain america", "fantastic four"],
    'dog breeds': ["corgis", "pomeranians", "beagles", "shiba inu", "greyhounds", "huskies", "Chihuahuas", "bulldogs"],
    'disney princesses': ["snow white", "jasmine", "cinderella", "aurora", "ariel", "belle", "pocahontas", "mulan", "tiana", "rapunzel", "merida"]
    'anime': ['cowboy bebop', 'space dandy', 'kill la kill', 'attack on titan']
}

# tags are represented as a set of regular expressions
all_tags = {
  'series': [
    {"name": "adventure time", "regex" : /^(adventure ?time)|(adventure time with finn and jake)$/i},
    {"name": "supernatural", "regex" : /^supernatural$/i},
    {"name": "doctor who", "regex" : /^(doctor ?who)|(dw)|(timey ?wimey)$/i},
    {"name" : "lord of the rings", "regex" : /^(lotr)|(lord ?of ?the ?rings)|(potatoes)$/i},
    {"name" : "harry potter" , "regex" :/^(harry ?potter)$/i} ],
  'characters': [
    {"name" : "hannibal lecter", "regex" : /^(hannibal ?lecter)$/i},
    {"name" : "mako mori" , "regex" : /^(mako ?mori)$/i},
    {"name" : "katniss everdeen", "regex" : /^(katniss ?everdeen)$/i} ]
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
