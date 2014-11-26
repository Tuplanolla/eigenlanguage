module Tester where

import Control.Applicative
import Control.Monad
import Data.Functor
import Data.Maybe
import Data.Text
import Data.Text.IO (readFile)
import Data.Traversable
import Data.Traversable.Instances
import Prelude hiding (readFile, traverse)
import System.Environment
import System.IO.Error

import Formatter
import Interpreter

help :: IO ()
help = do n <- getProgName
          putStrLn $ "Usage: " ++ n ++ " [file] [...]"

test :: FilePath -> IO ()
test fp = do p <- readFile fp
             let x = interpret p
             sequenceA $ put <$> x
             return ()

main :: IO ()
main = do as <- getArgs
          sequence_ $ test <$> as
