all:
	cd haskell && $(MAKE)

shallow-clean:
	cd haskell && $(MAKE) shallow-clean

clean:
	cd haskell && $(MAKE) clean

deep-clean:
	cd haskell && $(MAKE) deep-clean

run:
	cd haskell && $(MAKE) run

test:
	cd haskell && $(MAKE) test
