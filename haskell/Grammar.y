{-
letter = oneOf "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
sign = oneOf "+-"
digit = oneOf "0123456789"
special = oneOf "!$%&*+-./:;<=>?@[\]^_`{|}~"
reserved = oneOf "\"#'(),"
-}

{module Grammar where}

%error {choke}

%name decompose

%tokentype {Token}

%token symbol {TokenSymbol}
       "->"   {TokenFunction}
       "="    {TokenBinding}
       "'"    {TokenDataification}
       ","    {TokenCodeification}
       "("    {TokenGroupBegin}
       ")"    {TokenGroupEnd}

%%

expression : function
           | binding
           | dataification
           | atoms

function : "->" symbols atom

symbols : symbol
        | symbols symbol

atom : group
     | symbol

group : "(" expression ")"

symbol : "anything"

binding : "=" relations atom

relations : relation
          | relations relation

relation : symbol atom

dataification : "'" datum

datum : codeification
      | list
      | symbol

list : "(" elements ")"

elements : element
         | elements element

element : value
        | datum

codeification : "," atom

atoms : atom
      | atoms atom

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
