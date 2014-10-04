{
module Lexer (eigenlex) where

import Common (Code, Token (..))
}

%wrapper "basic"

$break = [\t\n\v\f\r\ ]
$linebreak = [\n\r]

lexemes :- $break+                            ;
           \%\ ~$linebreak*                   ;
           \%                                 {const TComment}
           `                                  {const TPack}
           \,                                 {const TUnpack}
           \(                                 {const TOpen}
           \)                                 {const TClose}
           \[                                 {const TListOpen}
           \]                                 {const TListClose}
           [\+\-]?[0-9]+(\^[0-9]+)?(_[0-9]+)? {TInteger . readInteger}
           -- TCyclotomic should be here and cover the complex field extension.
           '(\\.|[^\\'])+'                    {TCharacter . readCharacter}
           \"(\\.|[^\\\"])*\"                 {TString . readString}
           ~[\%`\,\(\)\[\]$break]+            {TSymbol}

{
readInteger :: Code -> Integer
readInteger = read -- This is wrong.

readCharacter :: Code -> Char
readCharacter = head . tail -- This is wrong.

readString :: Code -> String
readString = init . tail -- This is wrong.

eigenlex :: Code -> [Token]
eigenlex = alexScanTokens
}
