module Main where

import Core
import Evaluator
import Example
import Lexer
import Parser

main :: IO ()
main = print . eigenparse . eigenlex =<< getContents

loop :: IO ()
loop = undefined
