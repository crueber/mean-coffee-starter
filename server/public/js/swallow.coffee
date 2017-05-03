# Swallow console calls if one isn't available.
if !window.console
  names = ["log", "debug", "info", "warn", "error", "assert", "dir", "dirxml", "group", "groupEnd", "time", "timeEnd", "count", "trace", "profile", "profileEnd"]
  noop = ->
  window.console = {}
  for name in names then window.console[name] = noop