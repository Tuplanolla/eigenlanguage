module Main where

import Prelude hiding (showList)
import Data.Functor
import Data.List (intercalate)
import System.Environment

import Evaluator
import Formatter
import Lexer
import Parser
import Tester

main :: IO ()
main = do let f x @ (_ : _) = test x
              f _ = do putStrLn "Have an example then."
                       testExamples
          putStrLn "Write code?"
          x <- getContents
          f x

testExamples :: IO ()
testExamples = sequence_ $ test <$> tests

test :: String -> IO ()
test s = do putChar '\n'
            putStr ("Read:\n" ++ s)
            let t = eigenlex s
            putStrLn ("Tokenized:\n" ++ showList t)
            let e = eigenstrip (eigenparse t)
            putStrLn ("Parsed:\n" ++ show e)
            let f = eigenformat e
            putStrLn ("Formatted:\n" ++ f)
            -- let x = eigenevaluate e
            -- putStrLn ("Evaluated:\n" ++ show x)

showList :: Show a => [a] -> String
showList x = "[" ++ intercalate ", " (map show x) ++ "]"

loop :: IO ()
loop = undefined
