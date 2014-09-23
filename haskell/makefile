all: Main

shallow-clean:
	$(RM) *.hi *.o

clean: shallow-clean
	$(RM) Main

deep-clean: clean
	$(RM) Lexer.hs Parser.hs

Main: Main.hs Parser.hs
	ghc Main.hs

Parser.hs: Parser.y Lexer.hs
	happy Parser.y

Lexer.hs: Lexer.x
	alex Lexer.x
