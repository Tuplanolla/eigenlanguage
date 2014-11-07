module Common (Code, Environment, Expression (..), Name, Structure (..)) where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Prelude (Bool, Char, Integer, IO, Maybe, Show, String)
import System.IO (FilePath)

import Hack ()

data Expression = ESymbol Name
                | EPair Expression Expression
                | ENothing
                | EBinding Environment Expression
                | EFunction (Expression -> Expression)
                | EModule Name -- Something more here.
                | EEffect (IO Expression)
                | EUnique (IORef Bool)
                | EArray (Array Integer Expression) -- listArray (1, 0) []
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | EExternal FilePath
                | ESyntacticComment Code
                | EFreeComment Code
                | ETag Tag Expression
                deriving Show

data Tag = TRecursive Direction -- EPair
         | TArity Integer       -- EFunction
         | TOrder [Symbol]      -- EBinding
         | TRadix Integer       -- EInteger
         | TContinuous Bool     -- EPair for EStrings
         | TComment Span        -- EFreeComment
         | TLine Integer
         | TColumn Integer
         | TIndentation Integer
         deriving Show

data Direction = DLeft
               | DRight
               deriving Show

data Span = SLine
          | SBlock
          deriving Show

-- type Environment = [(Symbol, Expression)]
type Environment = Map Symbol Expression

-- type Symbol = String
type Symbol = Text

-- type Name = String
type Name = Text

-- type Code = String
type Code = Text
