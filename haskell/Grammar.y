{module Grammar where}

%tokentype {Token}

%token PACKING   {TPacking}
       UNPACKING {TUnpacking}
       OPENING   {TOpening}
       CLOSING   {TClosing}
       SYMBOL    {TSymbol $$}
       --
       LOGICAL   {TLogical $$}
       INTEGER   {TInteger $$}
       CHARACTER {TCharacter $$}
       STRING    {TString $$}

%error {eigenfail}

%name eigenparse program

%%

program :: {Structure}
        : pieces {$1}

piece : PACKING dpiece {$2}
      | group          {$1}
      | value          {$1}
      | SYMBOL         {SSymbol $1}

dpiece : UNPACKING piece {$2}
       | dgroup          {$1}
       | value           {$1}
       | SYMBOL          {SSymbol $1}

group : OPENING pieces CLOSING {$2}

dgroup : OPENING dpieces CLOSING {$2}

value : LOGICAL   {SLogical $1}
      | INTEGER   {SInteger $1}
      | CHARACTER {SCharacter $1}
      | STRING    {SString $1}

pieces : piece        {$1}
       | pieces piece {SApplication $1 $2}

dpieces : dpiece         {$1}
        | dpieces dpiece {SApplication $1 $2}

symbols : SYMBOL         {SSymbol $1}
        | symbols SYMBOL {SApplication $1 (SSymbol $2)}

{

data Token = TPacking
           | TUnpacking
           | TOpening
           | TClosing
           | TSymbol String
           --
           | TLogical Bool
           | TInteger Integer
           | TCharacter Char
           | TString String
           deriving Show

data Structure = SApplication Structure Structure
               | SSymbol String
               --
               | SLogical Bool
               | SInteger Integer
               | SCharacter Char
               | SString String
               deriving Show

eigenfail :: [Token] -> a
eigenfail = error . ("failed to parse: " ++) . showTokens

showTokens :: [Token] -> String
showTokens = foldr foldToken ""

foldToken :: Token -> String -> String
foldToken x y @ (_ : _) = show x ++ ' ' : y
foldToken x _ = show x

eigenlex :: String -> [Token]
eigenlex = const [TLogical True]

main :: IO ()
main = print . eigenparse . eigenlex =<< getContents

}

{-
import Data.Map

data Expression = EFunction (Expression -> Expression)
                | EApplication Expression Expression
                | EBinding (Map String Expression) Expression
                | ESymbol String
                | EPair Expression Expression
                --
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | EString String
                deriving Show
-}

{-
-- terminals

quote : '"'

hash : "#"

apostrophe : "'"

opening : "("

closing : ")"

prime : "`"

dprime : ","

sign : "+" | "-"

letter : "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"

digit : "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"

specialSansQuoteHashApoOparCpar : "!" | "$" | "%" | "&" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | "\\" | "]" | "^" | "_" | "`" | "{" | "|" | "}" | "~"

special : specialSansQuoteHashApoOparCpar | quote | hash | apostrophe | opening | closing

-- special : "!" | '"' | "#" | "$" | "%" | "&" | "'" | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | "<" | "=" | ">" | "?" | "@" | "[" | "\\" | "]" | "^" | "_" | "`" | "{" | "|" | "}" | "~"

anything : letter
         | digit
         | specialSansQuoteHashApoOparCpar -- eh

-- terminal groups

digits : digit
       | digits digit

letters : letter
        | letters letter

others : other
       | others other

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
lexington (')' : cs) = TokenGroupEnd : lexer cs

lexNum cs = TokenInt (read num) : lexer rest
            where (num,rest) = span isDigit cs

lexVar cs = case span isAlpha cs of
                 ("let", rest) -> TokenLet : lexer rest
                 ("in", rest) -> TokenIn : lexer rest
                 (var, rest) -> TokenVar var : lexer rest
-}
