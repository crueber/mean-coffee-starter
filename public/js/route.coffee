
router = ($routeProvider) ->
  $routeProvider.when('/', { controller: 'BaseCtrl', templateUrl: 'partials/base.html' })
                .otherwise({redirectTo: '/'})
                # .when('/here/:id.format?', { controller: 'HereCtrl', templateUrl: 'partials/here.html' })

router['$inject'] = ['$routeProvider']

rootModule.config router
