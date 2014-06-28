class Alias
  constructor: (names) ->
    @names = names
  name: -> @names[0]
  aliases: -> @names

all_tags = {
  'series': ["adventure time", "supernatural", "doctor who", "lotr", "harry potter"],
  'characters': ["hannibal lecter", "mako mori", "katniss everdeen"]
}

all_aliases = {
  'series': [new Alias(["adventure time", "adventuretime", "adventure time with finn and jake"]), new Alias(["supernatural"]), new Alias(["doctor who", "doctorwho", "dw", "timey wimey"]), new Alias(["lotr", "lord of the rings", "lordoftherings", "potatoes"]), new Alias(["harry potter", "harrypotter"])],
  'characters': [new Alias(["hannibal lecter", "hannibal", "hanniballecter"]), new Alias(["mako mori", "makomori"]), new Alias(["katniss everdeen", "katnisseverdeen"])]
}

tags = angular.module "common.tags", []

tags.service "TagsService", ->
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
