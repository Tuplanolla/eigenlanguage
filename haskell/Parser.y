{
module Parser where

import Data.Array (Array)
import Data.Map (Map)
import Text.Show.Functions ()

import Lexer
}

%tokentype {Token}

%token COMMENT   {TComment}
       PACK      {TPack}
       UNPACK    {TUnpack}
       OPEN      {TOpen}
       CLOSE     {TClose}
       SYMBOL    {TSymbol $$}
       --
       NOTHING   {TNothing}
       INTEGER   {TInteger $$}
       CHARACTER {TCharacter $$}
       STRING    {TString $$}

%name eigenparse program

%error {eigenfail}

%%

program :: {Expression}
        : pieces {$1}

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

group : OPEN pieces CLOSE {$2}

ungroup : OPEN unpieces CLOSE {$2}

value : NOTHING   {ENothing}
      | INTEGER   {EInteger $1}
      | CHARACTER {ECharacter $1}
      | STRING    {foldr (EPair . ECharacter) ENothing $1}

pieces : piece        {$1}
       | pieces piece {EApply $1 $2}

unpieces : unpiece          {$1}
         | unpieces unpiece {EApply $1 $2}

{
eigenfail :: [Token] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"

eigenstrip :: Expression -> Expression
eigenstrip (EApply EComment EComment) = ENothing
eigenstrip (EApply EComment y) = y
eigenstrip (EApply x EComment) = x
eigenstrip (EApply x y) = EApply (eigenstrip x) (eigenstrip y)
eigenstrip EComment = error "not an expression"
eigenstrip x = x

data Expression = EComment
                | EApply Expression Expression
                | ESymbol Name
                --
                | ENothing
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | EPair Expression Expression
                -- These may be wrong.
                | EFunction (Expression -> Expression) -- id
                | EBind Environment Expression -- fromList []
                | EArray (Array Int Expression) -- listArray (1, 0) []
                deriving Show

-- type Environment = Map Name Expression
type Environment = [(Name, Expression)]

type Name = String
}
