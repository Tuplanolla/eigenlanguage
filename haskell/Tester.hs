{-# LANGUAGE OverloadedStrings #-}

module Tester where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Control.Arrow
import Control.Monad hiding (sequence)
import Data.Function
import Data.Functor
import Data.Map hiding (filter, map, null)
import Data.Maybe
import Data.Text.Lazy hiding (empty, filter, map)
import Data.Text.Lazy.IO (readFile, putStr)
import Data.Traversable
import Data.Traversable.Instances
import Prelude hiding (concat, drop, lex, lines, lookup, null, putStr, readFile, sequence, traverse)
import System.Directory
import System.Environment
import System.FilePath
import System.IO.Error
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy
import qualified Text.Read as R

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
             let c = caseFromEntries (parseEntries t)
             case c of
                  Just c -> do putStrLn (name c ++ ":")
                               x <- rawParse <$> readFile (takeDirectory fp </> file c)
                               case x of
                                    Left pe -> print pe
                                    Right x -> putStrLn "parsed just fine"
                  _ -> do putStrLn ("\"" ++ fp ++ "\":")
                          putStrLn "mangled case file"
             putStrLn ""

data TestCase = TC {name :: String,
                    file :: FilePath,
                    parsed :: Maybe (Tree Parse),
                    compiled :: Maybe (Tree Expression),
                    evaluated :: Maybe Expression,
                    performed :: Maybe Text}
              deriving (Show)

-- | A poorly written function.
-- Converts key-value pairs into a test case.
caseFromEntries :: Map Text Text -> Maybe TestCase
caseFromEntries m = TC <$> (unpack <$> lookup "name" m)
                       <*> (unpack <$> lookup "file" m)
                       <*> pure (readMaybe =<< lookup "parsed" m)
                       <*> pure (const Nothing =<< lookup "compiled" m)
                       <*> pure (const Nothing =<< lookup "evaluated" m)
                       <*> pure (lookup "performed" m)

-- | A poorly written function.
-- Parses colon-separated key-value pairs.
parseEntries :: Text -> Map Text Text
parseEntries = fromList . filter (not . null . fst)
                        . map (second strip)
                        . map (first strip)
                        . map fromJust
                        . filter isJust
                        . map (splitWith ":")
                        . lines

-- | An addition to @Data.Text@.
-- A poorly written function.
-- Splits a text into two at the first occurrence of a separator.
-- The separator is not present in the results.
splitWith :: Text -> Text -> Maybe (Text, Text)
splitWith s = let f (t : ts) = Just (t, intercalate s ts)
                  f _ = Nothing in f . splitOn s

-- | An addition to @Text.Read@.
readMaybe :: Read a => Text -> Maybe a
readMaybe = R.readMaybe . unpack
