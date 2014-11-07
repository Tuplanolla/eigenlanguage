module Evaluator where

import Data.Map

import Common

evaluate :: Expression -> Expression
evaluate = evaluateWith empty

evaluateWith :: Environment -> Expression -> Expression
evaluateWith = undefined
