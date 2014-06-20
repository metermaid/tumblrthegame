tags = angular.module "common.tags", []

tags.service "TagsService", ->
  random_tag: (type) ->
    all_tags = {
      'series': ["adventure time", "supernatural", "doctor who", "lotr", "harry potter"],
      'characters': ["hannibal lecter", "mako mori", "katniss everdeen"]
    }
    tags = all_tags[type]
    return tags[Math.floor(Math.random() * tags.length)]