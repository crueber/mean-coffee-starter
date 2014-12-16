
###
This injector allows you to always test if there is a request in 
progress via the rootScope.http_working variable.
###
new_interceptor = ($q, $rootScope) ->
  req = 0
  {
    'request': (config) -> 
      req++
      $rootScope.httpInProgress = true
      config || $q.when(config)
    'response': (response) -> 
      req--
      if req == 0 
        $rootScope.httpInProgress = false
      return response || $q.when(response)
    'responseError': (response) -> 
      req--
      if req == 0 
        $rootScope.httpInProgress = false
      $q.reject(response)
  }
new_interceptor.$inject = ['$q', '$rootScope']

# 1) Set up then new interceptor in both the $http service, and restangular.
# 2) Set up restangular to automatically unwrap data responses.
# 3) Use the _id property on objects for the id when utilizing restangular, rather than 'id'. We're using mongo.
addl_config = ($httpProvider, RestangularProvider) -> 
  $httpProvider.interceptors.push new_interceptor
  RestangularProvider.setResponseExtractor (response, operation, what, url) -> response.data or response
  RestangularProvider.setRestangularFields id: "_id"
addl_config.$inject = ['$httpProvider', 'RestangularProvider']

# Inject the configuration in to the root module.
window.rootModule.config addl_config
