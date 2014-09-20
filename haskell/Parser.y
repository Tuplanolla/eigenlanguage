{
module Parser where

import Lexer
}

%tokentype {Lexeme}

%token PACKING   {LPacking}
       UNPACKING {LUnpacking}
       OPENING   {LOpening}
       CLOSING   {LClosing}
       SYMBOL    {LSymbol $$}
       --
       INTEGER   {LInteger $$}
       CHARACTER {LCharacter $$}
       STRING    {LString $$}

%error {eigenfail}

%name eigenparse program

%%

program :: {Parse}
        : pieces {$1}

piece : PACKING unpiece {$2}
      | group           {$1}
      | value           {$1}
      | SYMBOL          {PSymbol $1}

unpiece : UNPACKING piece {$2}
        | ungroup         {$1}
        | value           {$1}
        | SYMBOL          {PSymbol $1}

group : OPENING pieces CLOSING {$2}

ungroup : OPENING unpieces CLOSING {$2}

value : INTEGER   {PInteger $1}
      | CHARACTER {PCharacter $1}
      | STRING    {PString $1}

pieces : piece        {$1}
       | pieces piece {PApplication $1 $2}

unpieces : unpiece          {$1}
         | unpieces unpiece {PApplication $1 $2}

{
data Parse = PApplication Parse Parse
           | PSymbol String
           --
           | PInteger Integer
           | PCharacter Char
           | PString String
           deriving Show

eigenfail :: [Lexeme] -> a
eigenfail = error . ("failed to parse: " ++) . showLexemes

showLexemes :: [Lexeme] -> String
showLexemes = foldr foldLexeme ""

foldLexeme :: Lexeme -> String -> String
foldLexeme x y @ (_ : _) = show x ++ ' ' : y
foldLexeme x _ = show x
}
