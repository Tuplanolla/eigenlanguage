module Tester where

import Control.Applicative
import Control.Monad
import Data.Maybe
import Data.Text
import Data.Text.IO (readFile)
import Prelude hiding (readFile)
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
             display x

main :: IO ()
main = do as <- getArgs
          sequence_ $ test <$> as
