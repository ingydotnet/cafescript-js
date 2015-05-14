global.fs = require 'fs'
global.say = console.log
global.warn = console.warn
global.die = (s)->
  warn s
  process.exit 1
global.jjj = (o)->
  say JSON.stringify o
global.yyy = (o)->
  yaml = require 'js-yaml'
  say yaml.dump o
  o
global.xxx = (o)->
  die yyy o

