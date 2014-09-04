users = angular.module "common.user_storage", []

users.factory "gameStorage", ->
  defaults =
    current_round: '1'
    score: '0'
    lives: '5'

  service = 
    get: (storageID) ->
      sessionStorage.getItem(storageID) or defaults[storageID]
    increment: (storageID, n) ->
      service.put storageID, parseInt(service.get(storageID)) + parseInt(n)
    put: (storageID, game) ->
      sessionStorage.setItem(storageID, game)

  
  service