
state_tracker = (rootScope) ->
  rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
    _gaq.push [ '_trackEvent', 'site_navigation', fromState.name, fromParams, toState.name, toParams ]

  rootScope.$on '$stateNotFound', (event, failedState, fromState, fromParams) ->
    _gaq.push [ '_trackEvent', 'site_navigation_failure', fromState.name, fromParams, failedState ]

state_tracker.$inject = ['$rootScope']

window.rootModule.run state_tracker
