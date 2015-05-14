require './Prelude'

class global.CafeScript
  version: '0.0.1'

  run: (args)->
    input_file = args[0]
    input = String fs.readFileSync input_file

    require './CafeScript/Compiler'
    compiler = new CafeScript.Compiler

    ast = compiler.compile input

    yaml = require 'js-yaml'

    process.stdout.write yaml.dump ast
