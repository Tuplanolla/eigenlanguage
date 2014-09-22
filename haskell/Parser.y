{
module Parser where

import Lexer
}

%tokentype {Lexeme}

%token COMMENT   {LComment}
       PACK      {LPack}
       UNPACK    {LUnpack}
       OPEN      {LOpen}
       CLOSE     {LClose}
       SYMBOL    {LSymbol $$}
       --
       NOTHING   {LNothing}
       INTEGER   {LInteger $$}
       CHARACTER {LCharacter $$}
       STRING    {LString $$}

%name happyGatherParses

%error {happyError}

%%

program :: {Parse}
        : pieces {$1}

piece : COMMENT piece {PComment}
      | PACK unpiece  {PPack $2}
      | group         {$1}
      | value         {$1}
      | SYMBOL        {PSymbol $1}

unpiece : COMMENT unpiece {PComment}
        | UNPACK piece    {PUnpack $2}
        | ungroup         {$1}
        | value           {$1}
        | SYMBOL          {PSymbol $1}

group : OPEN pieces CLOSE {$2}

ungroup : OPEN unpieces CLOSE {$2}

value : NOTHING   {PNothing}
      | INTEGER   {PInteger $1}
      | CHARACTER {PCharacter $1}
      | STRING    {PString $1}

pieces : piece        {$1}
       | pieces piece {PApply $1 $2}

unpieces : unpiece          {$1}
         | unpieces unpiece {PApply $1 $2}

{
data Parse = PComment
           | PPack Parse
           | PUnpack Parse
           | PApply Parse Parse
           | PSymbol String
           --
           | PNothing
           | PInteger Integer
           | PCharacter Char
           | PString String
           deriving Show

happyError :: [Lexeme] -> a
happyError (x : _) = error ("failed to parse: " ++ show x)
happyError _ = error "failed to parse"
}
