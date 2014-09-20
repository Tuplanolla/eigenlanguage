{module Lexer where}

%wrapper "basic"

$space = [\t\n\v\f\r\ ]
$digit = [0-9]

tokens :- $space+ ;
          "#\ ".* ;
          ` {const LPacking}
          \, {const LUnpacking}
          \( {const LOpening}
          \) {const LClosing}
          [\+\-]?$digit+(\^$digit+)?(_$digit+)? {LInteger . readInteger}
          '(\\.|[^\\'])+' {LCharacter . readCharacter}
          \"(\\.|[^\\\"])*\" {LString . readString}
          ~[`\,\(\)$space]+ {LSymbol}

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

readInteger = read -- not quite

readCharacter = head -- not quite

readString = id -- not quite
}
