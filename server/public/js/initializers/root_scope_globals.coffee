
addl_setup = (rootScope, state, stateParams, $window) ->
  # Set reference to access them from any scope
  rootScope.$state = state;
  rootScope.$stateParams = stateParams;
  rootScope.user = $window.user
  rootScope.admin =
    name: 'MEAN Coffee Starter'
    description: 'MEAN Coffee Starter'
    tag: 'MEAN Coffee'

window.rootModule.run ['$rootScope', '$state', '$stateParams', '$window', addl_setup]
