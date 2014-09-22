{
module Lexer where
}

%wrapper "basic"

$break = [\t\n\v\f\r\ ]
$linebreak = [\n\r]

lexemes :- $break+                            ;
           \#\ ~$linebreak*                   ;
           \#                                 {const LComment}
           `                                  {const LPack}
           \,                                 {const LUnpack}
           \(                                 {const LOpen}
           \)                                 {const LClose}
           \(\)                               {const LNothing}
           [\+\-]?[0-9]+(\^[0-9]+)?(_[0-9]+)? {LInteger . readInteger}
           -- LCyclotomic should be here and cover the complex field extension.
           '(\\.|[^\\'])+'                    {LCharacter . readCharacter}
           \"(\\.|[^\\\"])*\"                 {LString . readString}
           ~[\#`\,\(\)$break]+                {LSymbol}

{
data Lexeme = LComment
            | LPack
            | LUnpack
            | LOpen
            | LClose
            | LSymbol String
            --
            | LNothing
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
