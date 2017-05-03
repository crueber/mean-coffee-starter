
location_initializer = (locationProvider) ->
  locationProvider.html5Mode(enabled: true, requireBase: false).hashPrefix('!')

location_initializer.$inject = ['$locationProvider' ]

window.rootModule.config location_initializer
