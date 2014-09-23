module Main where

import Prelude hiding (showList)
import Data.Functor
import Data.List (intercalate)
import System.Environment

-- import Evaluator
import Example
import Formatter
import Lexer
import Parser

main :: IO ()
main = do let f x @ (_ : _) = test x
              f _ = testExamples
          x <- getContents
          f x

testExamples :: IO ()
testExamples = sequence_ $ test <$> examples

test :: String -> IO ()
test s = do putStrLn ""
            putStrLn ("Read: " ++ s)
            let t = alexScanTokens s
            putStrLn ("Tokenized: " ++ showList t)
            let p = happyGatherParses t
            putStrLn ("Parsed: " ++ show p)
            let f = formatUnwrapped p
            putStrLn ("Formatted: " ++ f)
            -- x <- evaluateNowhere
            -- putStrLn ("Evaluated: " ++ show x)

showList :: Show a => [a] -> String
showList x = "[" ++ intercalate ", " (map show x) ++ "]"

loop :: IO ()
loop = undefined
