{
module Lexer where
}

%wrapper "basic"

$break = [\t\n\v\f\r\ ]
$linebreak = [\n\r]

lexemes :- $break+                            ;
           \#\ ~$linebreak*                   ; -- This is wrong.
           `                                  {const LPacking}
           \,                                 {const LUnpacking}
           \(                                 {const LOpening}
           \)                                 {const LClosing}
           [\+\-]?[0-9]+(\^[0-9]+)?(_[0-9]+)? {LInteger . readInteger}
           -- This should cover the cyclotomic subfield.
           '(\\.|[^\\'])+'                    {LCharacter . readCharacter}
           \"(\\.|[^\\\"])*\"                 {LString . readString}
           ~[\#`\,\(\)$break]+                {LSymbol}

{
data Lexeme = LPacking
            | LUnpacking
            | LOpening
            | LClosing
            | LSymbol String
            --
            | LInteger Integer
            | LCharacter Char
            | LString String
            deriving Show

readInteger :: String -> Integer
readInteger = read -- This is wrong.

readCharacter :: String -> Char
readCharacter = head -- This is wrong.

readString :: String -> String
readString = id -- This is wrong.
}
