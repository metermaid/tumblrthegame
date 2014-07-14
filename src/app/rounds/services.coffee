modules = [
  'ngResource'
]

services = angular.module 'rounds.services', modules

services.factory "RoundsRes", [
  "$resource"
  ($resource) ->
    return $resource("https://api.tumblr.com/v2/tagged?api_key=iI6dl4tEgEt96yvRl1urojakH0Wk86544k2ooTuNxHxVGysBMm&tag=:tag&before=:before&callback=JSON_CALLBACK", {},
      jsonp_query:
        cache: true
        method: "JSONP"
    )
]

# gives a random timestamp from the last number of months
services.service "RandomDateService", ->
  service =
    oneMonth: 2678400
    fromPastMonths: (months) ->
      (Date.now() - (Math.floor(Math.random() * service.oneMonth * months))) / 1000