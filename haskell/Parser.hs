{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Control.Monad
import Data.Char
import Data.Map hiding (foldl, foldr)
import Data.Text.Lazy hiding (foldl, foldr, group)
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import qualified Data.Tree as T

import Data

type ParserPos = GenParser SourcePos

($>) :: Functor f => f a -> b -> f b
($>) = flip (<$)
infixl 4 $>

tagPos :: SourcePos -> Expression -> Expression
tagPos sp = ETag (TFilePath (sourceName sp))
          . ETag (TLineNumber (sourceLine sp))
          . ETag (TColumnNumber (sourceColumn sp))

parseCode :: Code -> Either ParseFailure (Tree Parse)
parseCode t = case runParser program (initialPos "<interactive>") "<unteractive>" t of
                   Left _ -> Left PFFuckedUp -- Hides implementation details poorly.
                   Right x -> Right x

rawParse :: Code -> Either ParseError (Tree Parse)
rawParse = runParser program (initialPos "<interactive>") "<unteractive>" . strip

mediumParse :: ParserPos (Tree Parse) -> Code -> Either ParseError (Tree Parse)
mediumParse p = runParser p (initialPos "<interactive>") "<unteractive>" . strip

-- NO! Stop! Use a generic tree and abstract away the recursion!

program :: ParserPos (Tree Parse)
program = group foldl

expression :: ParserPos (Tree Parse)
expression = between (char '(') (char ')') (group foldl)
             <|> between (char '[') (char ']') (group foldr)
             <|> TElement <$> try symbol

group f = join between (many invisible)
          (f TPair (TElement PSingleton)
           <$> sepBy expression (many1 invisible))

invisible :: ParserPos Char
invisible = oneOf " \n\r"

symbol :: ParserPos Parse
symbol = PSymbol . pack <$> many1 (noneOf "()[]`,% \n\r")

convert (TElement x) = T.Node (show x) []
convert (TPair x y) = T.Node "" (convert <$> [x, y])
-- Data.Traversable.sequenceA $ putStrLn . T.drawTree . convert <$> it

-- Works.
-- runParser (anyRight (ESymbol . pack <$> string "f")) (initialPos "") "" "ffff"

anyLeft :: ParserPos (Tree a) -> a -> ParserPos (Tree a)
anyLeft p x = try (manyLeft p x) <|> pure (TElement x)

anyRight :: ParserPos (Tree a) -> a -> ParserPos (Tree a)
anyRight p x = try (manyRight p x) <|> pure (TElement x)

manyLeft :: ParserPos (Tree a) -> a -> ParserPos (Tree a)
manyLeft p x = try (flip TPair <$> p <*> manyLeft p x) <|> pure (TElement x)

manyRight :: ParserPos (Tree a) -> a -> ParserPos (Tree a)
manyRight p x = try (TPair <$> p <*> manyRight p x) <|> pure (TElement x)
