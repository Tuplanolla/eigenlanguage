module Main where

-- import Evaluator
import Example
import Formatter
import Lexer
import Parser

main :: IO ()
main = putStrLn . formatUnwrapped . eigenparse . alexScanTokens =<< getContents

loop :: IO ()
loop = undefined
