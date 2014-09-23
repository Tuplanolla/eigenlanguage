all: Main

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) Lexer.hs Parser.hs

Main: Analyzer.hs Evaluator.hs Formatter.hs Lexer.hs Main.hs Parser.hs Tester.hs
	ghc Main.hs

Parser.hs: Lexer.hs Parser.y
	happy Parser.y

Lexer.hs: Lexer.x
	alex Lexer.x
