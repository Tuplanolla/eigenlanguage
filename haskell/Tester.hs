{-# LANGUAGE OverloadedStrings #-}

module Tester where

import Control.Applicative
import Control.Monad
import Data.Functor
import Data.Maybe
import Data.Text.Lazy
import Data.Text.Lazy.IO (readFile, putStr)
import Data.Traversable
import Data.Traversable.Instances
import Prelude hiding (concat, lex, putStr, readFile, traverse)
import System.Environment
import System.IO.Error

import Formatter
-- import Interpreter
import Lexer
import Parser
import Data

help :: IO ()
help = do n <- getProgName
          putStrLn ("Usage: " ++ n ++ " [file] [...]")

test :: FilePath -> IO ()
test fp = do t <- readFile fp
             putStrLn fp
             let _ : ps = splitOn "\n\n" t -- Wrong; shitty libraries are to blame.
             let p = intercalate " " ps
             print p
             let x = rawParse p
             print x
{-
             let x = interpret p
             sequenceA $ put <$> x
             return ()
-}

main :: IO ()
main = do as <- getArgs
          sequence_ $ test <$> as

{-
let tests = ["arithmetic.eigen", "bind-many.eigen", "bind-one.eigen", "bind-recursive.eigen", "block-comment.eigen", "character.eigen", "comment.eigen", "complicated-io.eigen", "counter.eigen", "data.eigen", "data-embedded.eigen", "empty.eigen", "evaluate.eigen", "factorial.eigen", "fibonacci.eigen", "function-many.eigen", "function-one.eigen", "group-comment.eigen", "integer.eigen", "lazier.eigen", "lazy.eigen", "line-comment.eigen", "long-string.eigen", "modules.eigen", "natural.eigen", "nest-bind.eigen", "nothing.eigen", "parentheses.eigen", "shadow-bind.eigen", "simple-io.eigen", "string.eigen", "symbol-comment.eigen", "symbol.eigen", "wrong-io.eigen"]
sequence_ $ test . ("../tests/" ++) <$> tests
-}
