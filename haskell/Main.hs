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

gain, main :: IO () -- Swap these to disable the interactive prompt.
main = loop
gain = do let f x @ (_ : _) = test x
              f _ = do putStrLn "Have an example then."
                       testExamples
          putStrLn "Write code and hit done (Enter to flush and Ctrl D to stop), show examples (Ctrl D right now) or cancel (Ctrl C anywhere)."
          x <- getContents
          f x

testExamples :: IO ()
testExamples = sequence_ $ test <$> (code <$> filter (not . (`elem` ignored)
                                                          . name) tests)
               where ignored = [] -- All tests pass!

test :: String -> IO ()
test s = do putChar '\n'
            putStr ("Read:\n" ++ s)
            let t = eigenlex s
            putStrLn ("Tokenized:\n" ++ showWithSpaces t)
            let e = eigenparse t
            putStrLn ("Parsed:\n" ++ show e)
            let f = eigenformat e
            putStrLn ("Formatted:\n" ++ f)
            let x = eigenevaluate e
            putStrLn ("Evaluated:\n" ++ show x)
            case x of
                 EEffect a -> do putStr ("Forced:\n")
                                 _ <- a
                                 putLn
                 _ -> return ()

showWithSpaces :: Show a => [a] -> String
showWithSpaces = intercalate " " . map (("(" ++) . (++ ")") . show)
