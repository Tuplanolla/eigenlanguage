{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Data.Char
import Data.Map
import Data.Text.Lazy
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import Data
import Formatter -- No.

type ParserPos = GenParser SourcePos

($>) :: Functor f => f a -> b -> f b
($>) = flip (<$)
infixl 4 $>

tagPos :: SourcePos -> Expression -> Expression
tagPos sp = ETag (TFilePath (sourceName sp))
          . ETag (TLineNumber (sourceLine sp))
          . ETag (TColumnNumber (sourceColumn sp))

parse :: Text -> Either ParseFailure Expression
parse t = case runParser program (initialPos "<interactive>") "<unteractive>" t of
               Left _ -> Left PFFuckedUp -- Hides implementation details poorly.
               Right x -> Right x

rawParse :: Text -> Either ParseError Expression
rawParse t = untag <$> runParser program (initialPos "<interactive>") "<unteractive>" t

mediumParse :: ParserPos Expression -> Text -> Either ParseError Expression
mediumParse p t = untag <$> runParser p (initialPos "<interactive>") "<unteractive>" t

-- NO! Stop! Use a generic tree and abstract away the recursion!

program :: ParserPos Expression
program = undefined

-- Works.
-- runParser (anyRight (ESymbol . pack <$> string "f")) (initialPos "") "" "ffff"

anyLeft :: ParserPos Expression -> ParserPos Expression
anyLeft p = try (manyLeft p) <|> pure ESingleton

anyRight :: ParserPos Expression -> ParserPos Expression
anyRight p = try (manyRight p) <|> pure ESingleton

manyLeft :: ParserPos Expression -> ParserPos Expression
manyLeft p = try (flip EPair <$> p <*> manyLeft p) <|> pure ESingleton

manyRight :: ParserPos Expression -> ParserPos Expression
manyRight p = try (EPair <$> p <*> manyRight p) <|> pure ESingleton
