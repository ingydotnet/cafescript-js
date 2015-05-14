ifneq ($(PEGJS_DEBUG),)
  DEBUG = --trace
endif

PEGJS = pegjs --plugin pegjs-coffee-plugin $(DEBUG)

all: lib/CafeScript/Grammar.js

test: all
	bash test/test.bash

doc: ReadMe.pod

ReadMe.pod: doc/CafeScript.swim
	swim --to=pod --wrap --complete $< > $@

lib/CafeScript/Grammar.js: lib/CafeScript/Grammar.pegcoffee force
	$(PEGJS) $< $@.tmp
	mv $@.tmp $@

force:
