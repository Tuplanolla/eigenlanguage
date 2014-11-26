module Evaluator where

import Data.Map

import Data

evaluate :: Expression -> Either Failure Expression
evaluate = evaluateWith empty

evaluateWith :: Environment -> Expression -> Either Failure Expression
evaluateWith = undefined
