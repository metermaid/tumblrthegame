describe 'home section', ->

  AppCtrl = undefined
  $location = undefined
  $scope = undefined
  beforeEach module("ngBoilerplate.home")

  it "should have a dummy test", inject(->
     expect( true ).toBeTruthy()
  )
