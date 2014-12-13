module Interpreter where

-- import Control.Monad.State
import Data.Text

import Data
import Evaluator
import Parser

-- interpret :: Code -> Either Failure (State [Warning] Expression)
interpret :: Code -> Either Failure Expression
interpret c = do x <- parse c
                 evaluate x
