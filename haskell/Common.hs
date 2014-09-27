module Common (Code, Environment, Expression (..), Name, Structure (..),
               Token (..)) where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Prelude (Bool, Char, Integer, IO, Show, String)

import Hack ()

data Expression = EPair Expression Expression
                | ESymbol Name
                | ENothing
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | EFunction (Expression -> Expression)
                | EBind Environment Expression
                | EEffect (IO Expression)
                | EUnique (IORef Bool)
                | EArray (Array Integer Expression) -- listArray (1, 0) []
                deriving Show

data Structure = SComment
               | SPair Structure Structure
               | SSymbol Name
               | SNothing
               | SInteger Integer
               | SCharacter Char
               | SString String
               deriving Show

data Token = TComment
           | TPack
           | TUnpack
           | TOpen
           | TClose
           | TSymbol Name
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
