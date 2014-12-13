all: Interpreter

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) AutomaticallyGenerated.hs

run: Interpreter
	command -v rlwrap > /dev/null && rlwrap ./Main || ./Main

test: Interpreter
	command -v rlwrap > /dev/null && rlwrap ./Main b || ./Main b

document:
	haddock -h -o haddock Data.hs

Interpreter: Interpreter.hs
	ghc Interpreter.hs
