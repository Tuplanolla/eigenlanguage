module Common where

import Data.Array (Array)
import Data.Map (Map)
import Text.Show.Functions ()

data Expression = EComment
                | EPair Expression Expression
                | ESymbol Name
                --
                | ENothing
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                -- These may be wrong.
                | EFunction (Expression -> Expression) -- id
                | EProcedure (Expression -> IO Expression) -- return . id
                | EBind Environment Expression -- fromList []
                | EArray (Array Int Expression) -- listArray (1, 0) []
                deriving Show

data Token = TComment
           | TPack
           | TUnpack
           | TOpen
           | TClose
           | TSymbol Name
           --
           | TInteger Integer
           | TCharacter Char
           | TString String
           deriving Show

type Environment = Map Name Expression
-- type Environment = [(Name, Expression)]

type Name = String

-- type Code = Text
type Code = String
