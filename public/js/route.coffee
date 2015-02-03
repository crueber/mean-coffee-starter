
router = (stateProvider, urlRouterProvider) ->
  urlRouterProvider.when '', '/dashboard/home'
  urlRouterProvider.when '/', '/dashboard/home'
  urlRouterProvider.when '/dashboard', '/dashboard/home'
  urlRouterProvider.when '/logout', -> window.location = '/logout'
  urlRouterProvider.otherwise '/404'
  urlRouterProvider.otherwise '/dashboard'

  stateProvider.state 'dashboard',      url: '/dashboard', templateUrl: 'components/dashboard/base', abstract: true
  stateProvider.state 'dashboard.home', url: '/home',      templateUrl: 'components/home/base',      controller: 'HomeCtrl'

  stateProvider.state '404',       url: '/404',       templateUrl: 'shared/404'

router.$inject = ['$stateProvider', '$urlRouterProvider']

window.rootModule.config router
