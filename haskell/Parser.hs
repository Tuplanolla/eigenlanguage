{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Control.Monad
import Data.Char
import Data.Map hiding (foldl, foldr)
import Data.Sequence
import Data.Text.Lazy hiding (foldl, foldr, group)
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import qualified Data.Tree as T

import Data hiding (ParseError)
import qualified Data as Other

-- | Backtracking state for errors and warnings.
type ParserState = Seq (Location Warning)

type StatefulParser = GenParser ParserState

parseCode :: Code -> Either Other.ParseError (Tree Parse)
parseCode t = case runParser program Data.Sequence.empty "<interactive>" t of
                   Left _ -> Left PFFuckedUp -- Hides implementation details poorly.
                   Right x -> Right x

rawParse :: Code -> Either ParseError (ParserState, Tree Parse)
rawParse = runParser (withState program) Data.Sequence.empty "<interactive>"

withState p = flip (,) <$> p <*> getState

mediumParse :: StatefulParser (Tree Parse) -> Code -> Either ParseError (Tree Parse)
mediumParse p = runParser p Data.Sequence.empty "<interactive>"

program :: StatefulParser (Tree Parse)
program = group foldl <* eof

expression :: StatefulParser (Tree Parse)
expression = between (char '(') (char ')') (group foldl)
             <|> between (char '[') (char ']') (group foldr)
             <|> {- warnHere PWDubiousName *> -} (TElement <$> try symbol)

warnHere :: ParseWarning -> StatefulParser ()
warnHere w = getPosition >>= warn . f
 where f p = LLocation (sourceName p) (sourceLine p) (sourceColumn p) (WParse w)

warn :: Location Warning -> StatefulParser ()
warn = modifyState . flip (|>)

group f = join between (many invisible)
          (f TPair (TElement PSingleton)
           <$> sepEndBy expression (many1 invisible))

invisible :: StatefulParser Char
invisible = oneOf " \n\r"

symbol :: StatefulParser Parse
symbol = PSymbol . pack <$> many1 (noneOf "()[]`,% \n\r")

convert (TElement x) = T.Node (show x) []
convert (TPair x y) = T.Node "" (convert <$> [x, y])
-- Data.Traversable.sequenceA $ putStrLn . T.drawTree . convert <$> it

-- Works.
-- runParser (anyRight (ESymbol . pack <$> string "f")) (initialPos "") "" "ffff"

anyLeft :: StatefulParser (Tree a) -> a -> StatefulParser (Tree a)
anyLeft p x = try (manyLeft p x) <|> pure (TElement x)

anyRight :: StatefulParser (Tree a) -> a -> StatefulParser (Tree a)
anyRight p x = try (manyRight p x) <|> pure (TElement x)

manyLeft :: StatefulParser (Tree a) -> a -> StatefulParser (Tree a)
manyLeft p x = try (flip TPair <$> p <*> manyLeft p x) <|> pure (TElement x)

manyRight :: StatefulParser (Tree a) -> a -> StatefulParser (Tree a)
manyRight p x = try (TPair <$> p <*> manyRight p x) <|> pure (TElement x)
