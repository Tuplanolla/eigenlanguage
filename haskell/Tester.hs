{-# LANGUAGE OverloadedStrings #-}

module Tester where

import Control.Applicative
import Control.Monad hiding (sequence)
import Data.Functor
import Data.Maybe
import Data.Text.Lazy hiding (filter)
import Data.Text.Lazy.IO (readFile, putStr)
import Data.Traversable
import Data.Traversable.Instances
import Prelude hiding (concat, drop, lex, lines, putStr, readFile, sequence, traverse)
import System.Directory
import System.Environment
import System.FilePath
import System.IO.Error
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import Formatter
-- import Interpreter
import Lexer
import Parser
import Data hiding (ParseError)

main :: IO ()
main = getArgs >>= mapM_ testAll

help :: IO ()
help = do n <- getProgName
          putStrLn ("Usage: " ++ n ++ " [file] [...]")

testAll :: FilePath -> IO ()
testAll fp = do f <- doesFileExist fp
                d <- doesDirectoryExist fp
                case (f, d) of
                     (True, False) -> test fp
                     (False, True) -> do fps <- getDirectoryContents fp
                                         fps' <- filterM (liftM not . isHidden) fps
                                         mapM_ (testAll . (fp </>)) fps'
                     _ -> error (show (f, d))

isHidden :: FilePath -> IO Bool
isHidden fp = return $ case takeFileName fp of
                            c : _ -> c == '.'
                            _ -> False

test :: FilePath -> IO ()
test fp = do t <- readFile fp
             let c = intoCase t
             case c of
                  Left pe -> print pe
                  Right c -> do putStr (name c)
                                putStrLn (" (" ++ takeFileName fp ++ "):")
                                let x = rawParse (code c)
                                case x of
                                     Left pe -> print pe
                                     Right x -> putStrLn "parsed just fine"
             putStrLn ""

-- This is super dumb and fragile.
-- One should use a separate configuration file anyway, because
-- then tests could be reused for different stages.
intoCase :: Text -> Either ParseError Case
intoCase t = let a : cs = splitOn "\n\n" t
                 c = intercalate " " cs
                 n : f : s : e : _ = (!! 1) . splitOn ": " . drop 2 <$> lines t in
                 return (CCase n (splitOn ", " f) s e c)

data Stage = SParse
           | SNormalize
           | SEvaluate
           | SPerform
           deriving (Eq, Ord, Show)

data Case = CCase {name :: Text,
                   features :: [Text],
                   stage :: Text,
                   expected :: Text,
                   code :: Code}
          deriving (Eq, Show)
