{-# LANGUAGE OverloadedStrings #-}

module Tester where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Control.Arrow
import Control.Monad hiding (sequence)
import Data.Function
import Data.Functor
import Data.Maybe
import Data.Map hiding (filter, map, null)
import Data.Text.Lazy hiding (empty, filter, map)
import Data.Text.Lazy.IO (readFile, putStr)
import Data.Traversable
import Data.Traversable.Instances
import Prelude hiding (concat, drop, length, lex, lines, lookup, null, putStr, readFile, sequence, traverse)
import System.Directory
import System.Environment
import System.FilePath
import System.IO.Error
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import Extensions
import Formatter
-- import Interpreter
import Lexer
import Parser
import Data hiding (ParseError)

main :: IO ()
main = getArgs >>= mapM_ testAll

help :: IO ()
help = do s <- getProgName
          putStrLn ("Usage: " ++ s ++ " [file] [...]")

testAll :: FilePath -> IO ()
testAll fp = do f <- doesFileExist fp
                d <- doesDirectoryExist fp
                case (f, d) of
                     (True, False) -> when (takeExtension fp == ".case") (test fp)
                     (False, True) -> do fps <- filter (not . isDot) <$> getDirectoryContents fp
                                         mapM_ (testAll . (fp </>)) fps
                     _ -> error (show (f, d))

isDot :: FilePath -> Bool
isDot (x : _) = x == '.'
isDot _ = False

test :: FilePath -> IO ()
test fp = do t <- readFile fp
             case caseFromEntries (parseEntries t) of
                  Just c -> testCase fp c
                  _ -> do putStrLn ("\"" ++ fp ++ "\":")
                          putStrLn "mangled case file"
             putStrLn ""

testCase :: FilePath -> TestCase -> IO ()
testCase fp tc = do putStrLn (name tc ++ ":")
                    -- Dispatch stages here instead.
                    x <- rawParse <$> readFile (takeDirectory fp </> file tc)
                    case x of
                         Left pe -> print pe
                         Right x -> putStrLn "parsed just fine"

-- | A test description, file and expected values for various actions.
data TestCase = TC {name :: String,
                    file :: FilePath,
                    parsed :: Maybe (Either Char (Tree Parse)), -- Char -> ParseError...
                    compiled :: Maybe (Tree Expression), -- CompilationError...
                    evaluated :: Maybe Expression,
                    performed :: Maybe Text}
              deriving (Show)

-- | A poorly written function.
-- Converts key-value pairs into a test case.
caseFromEntries :: Map Text Text -> Maybe TestCase
caseFromEntries m = TC <$> (unpack <$> lookup "name" m)
                       <*> (unpack <$> lookup "file" m)
                       <*> pure (readMaybeText =<< lookup "parsed" m)
                       <*> pure (const Nothing =<< lookup "compiled" m)
                       <*> pure (const Nothing =<< lookup "evaluated" m)
                       <*> pure (lookup "performed" m)

-- | A poorly written function.
-- Parses colon-separated key-value pairs.
parseEntries :: Text -> Map Text Text
parseEntries = fromList . filter (not . null . fst)
                        . fmap (first strip . second strip)
                        . catMaybes
                        . fmap (breakAround ":")
                        . lines
