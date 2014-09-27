# Eigenlanguage

Eigenlanguage is a programming language prototype.
It is a purely functional, dynamically typed and lazily evaluated one.
Its features are a mix of the most distinct features of Haskell, Scheme and J.
The goal is to make it as minimal as possible and focus on pedagogical aspects.
Symmetries similar to those in physics will also be emphasized heavily.
It is by no means a serious project, but might one day turn out to be.

A detailed explanation in the form of unintelligible rambling is available on
[the author's personal website](http://users.jyu.fi/~sapekiis/eigenlanguage/).

	$ ./Main
	Eigenlanguage Interpreter 0.0.0/2014-09-28 (approximately)
	%#1 % This is a comment.
	%#2 + 1 2 % Warmup arithmetic.
	3
	%#3 * # 2 % Previous results are bound to # and friends.
	6
	%#4 < #3 #2 % These are the friends.
	false
	%#5 if # unbound-identifier 42 % Lazy evaluation only does what is needed.
	42
	%#6 `(- 43 ,#) % Code is data...
	- 43 42
	%#7 evaluate # % ...and data is code.
	1
	%#8 print-character '?' io % Input and output make use of a uniqueness type.
	IO
	%# #perform % The result is merely a description of effects that can be run.
	?
	%#9 = (square (-> x
	%..               (* x x))
	%..    meaning #5) (square meaning) % Those were the three special forms.
	1764
	%#10 - # %(This is a syntactic comment.) 1024
	740
	%#11 always 13 unbound-identifier % This is an ordinary function, like if.
	13
	%#12 = (f (-> n
	%...          (if (< n 2)
	%...              n
	%...              (+ (f (- n 1))
	%...                 (f (- n 2)))))) (f #) % Recursive bindings work fine.
	233
	%#13 = (f (-> n
	%...          (if (< n 1)
	%...              #
	%...              (f (- n 1))))) (f 1048576) % Tail calls are optimized.
	233
	%#14 #quit
