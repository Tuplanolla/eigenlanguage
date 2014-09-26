module Common (Code, Environment, Expression (..), Name, Token (..)) where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Prelude (Bool, Char, Integer, IO, Show, String)

import Hack ()

data Expression = EComment
                | EPair Expression Expression
                | ESymbol Name
                --
                | ENothing
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                -- These may be wrong.
                | EUnique (IORef Bool)
                | EFunction (Expression -> Expression) -- id
                | EProcedure (Expression -> IO Expression) -- return . id
                | EBind Environment Expression -- fromList []
                | EArray (Array Integer Expression) -- listArray (1, 0) []
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

-- type Environment = [(Name, Expression)]
type Environment = Map Name Expression

-- type Name = Text
type Name = String

-- type Code = Text
type Code = String
