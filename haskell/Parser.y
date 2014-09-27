{
module Parser (eigenparse) where

import Common (Expression (..), Structure (..), Token (..))
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

%name eigenstructure program

%%

program :: {Structure}
        : something {$1}

piece : COMMENT piece {SComment}
      | PACK unpiece  {SPair (SSymbol "`") $2}
      | group         {$1}
      | value         {$1}
      | SYMBOL        {SSymbol $1}

unpiece : COMMENT unpiece {SComment}
        | UNPACK piece    {SPair (SSymbol ",") $2}
        | ungroup         {$1}
        | value           {$1}
        | SYMBOL          {SSymbol $1}

group : OPEN something CLOSE {$2}

ungroup : OPEN unsomething CLOSE {$2}

something : {- NOTHING -} {SNothing}
          | pieces        {$1}

unsomething : {- NOTHING -} {SNothing}
            | unpieces      {$1}

pieces : piece        {$1}
       | pieces piece {SPair $1 $2}

unpieces : unpiece          {$1}
         | unpieces unpiece {SPair $1 $2}

value : INTEGER   {SInteger $1}
      | CHARACTER {SCharacter $1}
      | STRING    {SPair (SSymbol "`") (SString $1)}

{
eigenfail :: [Token] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"

eigenparse :: [Token] -> Expression
eigenparse = eigenexpress . eigenstructure

eigenexpress :: Structure -> Expression
eigenexpress SComment = ENothing
eigenexpress (SPair SComment SComment) = ENothing
eigenexpress (SPair SComment y) = eigenexpress y
eigenexpress (SPair x SComment) = eigenexpress x
eigenexpress (SPair x y) = EPair (eigenexpress x) (eigenexpress y)
eigenexpress (SSymbol x) = ESymbol x
eigenexpress SNothing = ENothing
eigenexpress (SInteger x) = EInteger x
eigenexpress (SCharacter x) = ECharacter x
eigenexpress (SString x) = foldr (EPair . ECharacter) ENothing x
}
