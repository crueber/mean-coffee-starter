
router = (stateProvider, urlRouterProvider) ->
  urlRouterProvider.otherwise '/dashboard'

  stateProvider.state 'dashboard',
    url: '/dashboard'
    templateUrl: 'templates/base'
    controller: 'BaseCtrl'

router.$inject = ['$stateProvider', '$urlRouterProvider']

window.rootModule.config router
