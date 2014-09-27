all: Main

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) Lexer.hs Parser.hs

run: Main
	command -v rlwrap > /dev/null && rlwrap ./Main b || ./Main b

Main: Common.hs Evaluator.hs Formatter.hs Hack.hs Interpreter.hs Lexer.hs Main.hs Parser.hs Tester.hs
	ghc Main.hs

Parser.hs: Common.hs Lexer.hs Parser.y
	happy Parser.y

Lexer.hs: Common.hs Lexer.x
	alex Lexer.x
