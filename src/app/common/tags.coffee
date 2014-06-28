class Alias
  constructor: (names) ->
    @names = names
  name: -> @names[0]
  aliases: -> @names

all_tags: {
    'TV series': ["adventure time", "supernatural", "doctor who", "sherlock", "community", "parks and recreation", "the big bang theory"],
    'Cartoons': ["my little pony", "adventure time", "gravity falls", "powerpuff girls", "the last airbender", "steven universe"]
    'characters': ["hannibal lecter", "mako mori", "katniss everdeen"],
    'homestuck': ['dave strider', 'roxy lalonde', 'nepeta', 'john egbert', 'vriska serket', 'tavros nitram', 'terezi', 'equius']
    'marvel': ["spiderman", "avengers", "iron man", "doctor strange", "hulk", "captain america", "fantastic four"],
    'dog breeds': ["corgis", "pomeranians", "beagles", "shiba inu", "greyhounds", "huskies", "Chihuahuas", "bulldogs"],
    'disney princesses': ["snow white", "jasmine", "cinderella", "aurora", "ariel", "belle", "pocahontas", "mulan", "tiana", "rapunzel", "merida"]
    'anime': ['cowboy bebop', 'space dandy', 'kill la kill', 'attack on titan']
}

all_aliases = {
  'series': [new Alias(["adventure time", "adventuretime", "adventure time with finn and jake"]), new Alias(["supernatural"]), new Alias(["doctor who", "doctorwho", "dw", "timey wimey"]), new Alias(["lotr", "lord of the rings", "lordoftherings", "potatoes"]), new Alias(["harry potter", "harrypotter"])],
  'characters': [new Alias(["hannibal lecter", "hanniballecter"]), new Alias(["mako mori", "makomori"]), new Alias(["katniss everdeen", "katnisseverdeen"])]
}

tags = angular.module "common.tags", []

tags.service "TagsService", ->
  random_categories: (length) ->
    categories = Object.keys(all_aliases)
    # From the end of the list to the beginning, pick element `i`.
    for i in [categories.length-1..1]
      # Choose random element `j` to the front of `i` to swap with.
      j = Math.floor Math.random() * (i + 1)
      # Swap `j` with `i`, using destructured assignment
      [categories[i], categories[j]] = [categories[j], categories[i]]
    # Return the shuffled array.
    categories.slice(0,length)
  check_tag_aliases: (type, tag, guess) ->
    console.log("type:" + type + " tag:" + tag + " guess:" + guess)
    aliases = all_aliases[type]
    tagFound = false
    alias = null
    # we loop over aliases sets and find the one that mathes our tag
    for a in aliases
      if tag in a.names then alias = a
      if alias then break
    if guess in alias.aliases() then true else false
  random_tag: (type) ->
    aliases = all_aliases[type]
    return aliases[Math.floor(Math.random() * aliases.length)].name()
