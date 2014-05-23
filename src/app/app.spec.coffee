describe 'AppCtrl', ->

  AppCtrl = undefined
  $location = undefined
  $scope = undefined
  beforeEach module("ngBoilerplate")

  it "should have a dummy test", inject(->
     expect( true ).toBeTruthy()
  )
