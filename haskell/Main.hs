module Main where

import Data.Functor
import Data.List (elem, intercalate)
import System.Environment

import Common
import Evaluator
import Formatter
import Interpreter
import Lexer
import Parser
import Tester

main :: IO ()
main = do a <- getArgs
          case a of
             (_ : _) -> testExamples
             _ -> loop

testExamples :: IO ()
testExamples = sequence_ $ test <$> (code <$> filter (not . (`elem` ignored)
                                                          . name) tests)
               where ignored = ["Tail"] -- All tests pass, but Tail is slow.

test :: String -> IO ()
test s = do putChar '\n'
            putStr ("Read:\n" ++ s)
            let t = eigenlex s
            putStrLn ("Tokenized:\n" ++ showWithSpaces t)
            let e = eigenparse t
            putStrLn ("Parsed:\n" ++ show e)
            let f = eigenformat e
            putStrLn ("Formatted:\n" ++ f)
            putStr "Colorized:\n"
            eigenformatIO e
            putStrLn ""
            let x = eigenevaluate e
            putStrLn ("Evaluated:\n" ++ show x)
            case x of
                 EEffect a -> do putStr ("Performed:\n")
                                 _ <- a
                                 putLn
                 _ -> return ()

showWithSpaces :: Show a => [a] -> String
showWithSpaces = intercalate " " . map (("(" ++) . (++ ")") . show)
