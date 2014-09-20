module Main where

import Core
import Evaluator
import Example
import Lexer
import Parser

main :: IO ()
main = print . eigenparse . alexScanTokens =<< getContents

loop :: IO ()
loop = undefined
