{
module Lexer where
}

%wrapper "basic"

$break = [\t\n\v\f\r\ ]
$linebreak = [\n\r]

lexemes :- $break+                            ;
           \#\ ~$linebreak*                   ;
           \#                                 {const TComment}
           `                                  {const TPack}
           \,                                 {const TUnpack}
           \(                                 {const TOpen}
           \)                                 {const TClose}
           \(\)                               {const TNothing}
           [\+\-]?[0-9]+(\^[0-9]+)?(_[0-9]+)? {TInteger . readInteger}
           -- TCyclotomic should be here and cover the complex field extension.
           '(\\.|[^\\'])+'                    {TCharacter . readCharacter}
           \"(\\.|[^\\\"])*\"                 {TString . readString}
           ~[\#`\,\(\)$break]+                {TSymbol}

{
readInteger :: String -> Integer
readInteger = read -- This is wrong.

readCharacter :: String -> Char
readCharacter = head . tail -- This is wrong.

readString :: String -> String
readString = init . tail -- This is wrong.

eigenlex :: String -> [Token]
eigenlex = alexScanTokens

data Token = TComment
           | TPack
           | TUnpack
           | TOpen
           | TClose
           | TSymbol String
           --
           | TNothing
           | TInteger Integer
           | TCharacter Char
           | TString String
           deriving Show
}
