
to_run = (cache, $window) ->
  if $window.JST
    _.forOwn $window.JST, (content, name) -> 
      cache.put name, content
to_run.$inject = ['$templateCache', '$window']

window.rootModule.run to_run
