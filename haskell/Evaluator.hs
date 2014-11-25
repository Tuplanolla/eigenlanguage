module Evaluator where

import Data.Map

import Data

evaluate :: Expression -> Expression
evaluate = evaluateWith empty

evaluateWith :: Environment -> Expression -> Expression
evaluateWith = undefined
