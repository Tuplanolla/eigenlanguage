{
module Parser (eigenparse) where

import Common
}

%tokentype {Token}

%token COMMENT   {TComment}
       PACK      {TPack}
       UNPACK    {TUnpack}
       OPEN      {TOpen}
       CLOSE     {TClose}
       SYMBOL    {TSymbol $$}
       --
       INTEGER   {TInteger $$}
       CHARACTER {TCharacter $$}
       STRING    {TString $$}

%error {eigenfail}

%name eigensemiparse program

%%

program :: {Expression}
        : something {$1}

piece : COMMENT piece {EComment}
      | PACK unpiece  {EApply (ESymbol "`") $2}
      | group         {$1}
      | value         {$1}
      | SYMBOL        {ESymbol $1}

unpiece : COMMENT unpiece {EComment}
        | UNPACK piece    {EApply (ESymbol ",") $2}
        | ungroup         {$1}
        | value           {$1}
        | SYMBOL          {ESymbol $1}

group : OPEN something CLOSE {$2}

ungroup : OPEN unsomething CLOSE {$2}

something : {- NOTHING -} {ENothing}
          | pieces        {$1}

unsomething : {- NOTHING -} {ENothing}
            | unpieces      {$1}

pieces : piece        {$1}
       | pieces piece {EApply $1 $2}

unpieces : unpiece          {$1}
         | unpieces unpiece {EApply $1 $2}

value : INTEGER   {EInteger $1}
      | CHARACTER {ECharacter $1}
      | STRING    {foldr (EPair . ECharacter) ENothing $1}

{
eigenfail :: [Token] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"

eigenparse :: [Token] -> Expression
eigenparse = eigenstrip . eigensemiparse

eigenstrip :: Expression -> Expression
eigenstrip (EApply EComment EComment) = ENothing
eigenstrip (EApply EComment y) = eigenstrip y
eigenstrip (EApply x EComment) = eigenstrip x
eigenstrip (EApply x y) = EApply (eigenstrip x) (eigenstrip y)
eigenstrip EComment = error "not an expression"
eigenstrip x = x
}
