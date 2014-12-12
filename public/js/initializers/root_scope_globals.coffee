
addl_setup = (rootScope, state, stateParams) ->
  # Set reference to access them from any scope
  rootScope.$state = state;
  rootScope.$stateParams = stateParams;
  rootScope.admin =
    name: 'MEAN Coffee Starter'
    description: 'MEAN Coffee Starter'
    tag: 'MEAN Coffee'

window.rootModule.run ['$rootScope', '$state', '$stateParams', addl_setup]
