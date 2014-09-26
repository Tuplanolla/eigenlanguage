all: Main

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) Lexer.hs Parser.hs

run: Main
	command -v rlwrap && rlwrap ./Main || ./Main

Main: Common.hs Evaluator.hs Formatter.hs Interpreter.hs Lexer.hs Main.hs Parser.hs Tester.hs
	ghc Main.hs

Parser.hs: Common.hs Lexer.hs Parser.y
	happy Parser.y

Lexer.hs: Common.hs Lexer.x
	alex Lexer.x
