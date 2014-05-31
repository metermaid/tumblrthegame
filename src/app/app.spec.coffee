describe 'AppCtrl', ->

  AppCtrl = undefined
  $location = undefined
  $scope = undefined
  beforeEach module("tumblrGame")

  it "should have a dummy test", inject(->
     expect( true ).toBeTruthy()
  )
