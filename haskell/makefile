all: Main

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) AutomaticallyGenerated.hs

run: Main
	command -v rlwrap > /dev/null && rlwrap ./Main || ./Main

test: Main
	command -v rlwrap > /dev/null && rlwrap ./Main b || ./Main b

document:
	haddock -h -o haddock Data.hs

Main: Main.hs
	ghc Main.hs
