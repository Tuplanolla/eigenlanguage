{module Grammar where}

%error {choke}

%name decompose

%tokentype {Token}

%token symbol {TokenSymbol}
       "`"    {TokenData}
       ","    {TokenCode}
       "("    {TokenGroupBegin}
       ")"    {TokenGroupEnd}

%%

-- nonterminals

program : pieces

piece : "`" dpiece
      | group
      | symbol

dpiece : "," piece
       | dgroup
       | symbol

group : opening pieces closing

dgroup : opening dpieces closing

symbol : letter
       -- | letter anythingButReserved
       | letter anything

value : integer
      | character
      | string

integer : sign digits
        | digits

-- character : apostrophe anythingButApostrophe apostrophe
character : apostrophe anything apostrophe

-- string : quote anythingButQuote quote
string : quote anything quote

-- nonterminal groups

pieces : piece
       | pieces piece

dpieces : dpiece
        | dpieces dpiece

symbols : symbol
        | symbols symbol

-- terminals

quote = '"'

hash = "#"

apostrophe = "'"

opening = "("

closing = ")"

comma = ","

sign = "+" | "-"

letter = "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"

digit : "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

specialSansQuoteHashApoOparCpar = "!" | "$" | "%" | "&" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | "\\" | "]" | "^" | "_" | "`" | "{" | "|" | "}" | "~"

special = specialSansQuoteHashApoOparCpar | quote | hash | apostrophe | opening | closing

-- special = "!" | '"' | "#" | "$" | "%" | "&" | "'" | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | "\\" | "]" | "^" | "_" | "`" | "{" | "|" | "}" | "~"

anything = letter
         | digit
         | specialSansQuoteHashApoOparCpar -- eh

-- terminal groups

digits : digit
       | digits digit

letters : letter
        | letters letter

others : other
       | others other

{-
choke :: [Token] -> a
choke _ = error ("Parse error\n")

data Exp = Let String Exp Exp
         | Exp1 Exp1
data Exp1 = Plus Exp1 Term
          | Minus Exp1 Term
          | Term Term
data Term = Times Term Factor
          | Div Term Factor
          | Factor Factor
data Factor = Int Int
            | Var String
            | Brack Exp
data Token = TokenLet
           | TokenIn
           | TokenInt Int
           | TokenVar String
           | TokenEq
           | TokenPlus
           | TokenMinus
           | TokenTimes
           | TokenDiv
           | TokenGroupBegin
           | TokenGroupEnd
data E = L Bool -- Logical
       | I Integer -- Integer
       | C Char -- Character
       | S String -- String
       | F (E -> E) -- Function
       | A E E -- Application
       | B [(String, E)] E -- Binding
       | R String -- Reference
       deriving Show -- Expression

lexington :: String -> [Token]
lexington [] = []
lexington (c : cs) | isSpace c = lexer cs
                   | isAlpha c = lexVar (c : cs)
                   | isDigit c = lexNum (c : cs)
lexington ('=' : cs) = TokenEq : lexer cs
lexington ('+' : cs) = TokenPlus : lexer cs
lexington ('-' : cs) = TokenMinus : lexer cs
lexington ('*' : cs) = TokenTimes : lexer cs
lexington ('/' : cs) = TokenDiv : lexer cs
lexington ('(' : cs) = TokenGroupBegin : lexer cs
lexington (')' : cs) = gokenGroupEnd : lexer cs

lexNum cs = TokenInt (read num) : lexer rest
            where (num,rest) = span isDigit cs

lexVar cs = case span isAlpha cs of
                 ("let", rest) -> TokenLet : lexer rest
                 ("in", rest) -> TokenIn : lexer rest
                 (var, rest) -> TokenVar var : lexer rest
-}
