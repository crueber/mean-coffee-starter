#= require_self
#= require_tree initializers

# Root Module for the project.
window.rootModule = angular.module 'root', [
  'ui.router'
  'ngSanitize'
  'ngAnimate'
  'restangular'
  'ui.bootstrap.dropdown'
]
