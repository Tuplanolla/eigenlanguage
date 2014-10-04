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
       LISTOPEN  {TListOpen}
       LISTCLOSE {TListClose}
       SYMBOL    {TSymbol $$}
       INTEGER   {TInteger $$}
       CHARACTER {TCharacter $$}
       STRING    {TString $$}

%error {eigenfail}

%name eigenstructure program

%%

program :: {Structure}
        : maybepieces {$1}

maybepieces : {- NOTHING -} {SNothing}
            | pieces        {$1}

pieces : piece        {$1}
       | pieces piece {SPair $1 $2}

piece : COMMENT piece {SComment}
      | PACK unpiece  {SPack $2} -- This is perhaps deprecated.
      | list          {$1}
      | group         {$1}
      | value         {$1}
      | SYMBOL        {SSymbol $1}

list : LISTOPEN maybeelements LISTCLOSE {SPack (SList $2)}

maybeelements : {- NOTHING -}       {[]}
              | piece maybeelements {$1 : $2} -- This is risky for the stack.

group : OPEN maybepieces CLOSE {$2}

value : INTEGER   {SInteger $1}
      | CHARACTER {SCharacter $1}
      | STRING    {SPack (SString $1)}

-- The utility of these is questionable.

unpiece : COMMENT unpiece {SComment}
        | UNPACK piece    {SUnpack $2}
        | ungroup         {$1}
        | value           {$1}
        | SYMBOL          {SSymbol $1}

ungroup : OPEN maybeunpieces CLOSE {$2}

maybeunpieces : {- NOTHING -} {SNothing}
              | unpieces      {$1}

unpieces : unpiece          {$1}
         | unpieces unpiece {SPair $1 $2}

{
eigenfail :: [Token] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"

eigenparse :: [Token] -> Expression
eigenparse = eigenexpress . eigenstructure

eigenexpress :: Structure -> Expression
eigenexpress SComment = ENothing
eigenexpress (SPack x) = EPair (ESymbol "`") (eigenexpress x)
eigenexpress (SUnpack x) = EPair (ESymbol ",") (eigenexpress x)
eigenexpress (SPair SComment SComment) = ENothing
eigenexpress (SPair SComment y) = eigenexpress y
eigenexpress (SPair x SComment) = eigenexpress x
eigenexpress (SPair x y) = EPair (eigenexpress x) (eigenexpress y)
eigenexpress (SSymbol x) = ESymbol x
eigenexpress (SList x) = foldr (EPair . eigenexpress) ENothing x
eigenexpress SNothing = ENothing
eigenexpress (SInteger x) = EInteger x
eigenexpress (SCharacter x) = ECharacter x
eigenexpress (SString x) = foldr (EPair . ECharacter) ENothing x
}
