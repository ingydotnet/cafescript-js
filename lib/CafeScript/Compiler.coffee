require '../CafeScript'
grammar = require '../CafeScript/Grammar'
{sprintf} = require 'sprintf'

class CafeScript.Compiler
  compile: (cafescript)->
    global.buffer = cafescript
    if process.env.PEGJS_DEBUG
      ast = grammar.parse cafescript, {tracer: new Tracer}
    else
      ast = grammar.parse cafescript

class Tracer
  indent: 1
  trace: (e)->
    {type, rule, location} = e
    offset = location.start.offset
    verb = if type is 'rule.enter' then 'try' else \
      if type is 'rule.match' then 'got' else \
      if type is 'rule.fail' then 'not' else \
      die "Unknown type #{type}"
    snippet = buffer[offset..(offset+10)]
    snippet = snippet.replace /\n/g, '\\n'
    snippet = snippet.replace /\t/g, '\\t'
    snippet = '' if verb is 'got' or verb is 'not'
    @indent-- if verb is 'not' or verb is 'got'
    msg = sprintf "%#{@indent}s%s %-30s %s", ' ', verb, rule, snippet
    @indent++ if verb is 'try'
    say msg[1..]
