{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Data.Char
import Data.Map
import Data.Monoid
import Data.Text.Lazy hiding (singleton)
import Prelude hiding (lex)
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos
import Text.Parsec.Text.Lazy

import Data
import Formatter -- No.
import Lexer

type ExpressionParser = Parsec [Lexeme] ({- State -}) Expression

($>) :: Functor f => f a -> b -> f b
($>) = flip (<$)
infixl 4 $>

tagPos :: SourcePos -> Expression -> Expression
tagPos sp = ETag (TFilePath (sourceName sp))
          . ETag (TLineNumber (sourceLine sp))
          . ETag (TColumnNumber (sourceColumn sp))

-- And now for some trash that does not compile...

parse :: [Lexeme] -> Either ParseFailure Expression
parse t = case runParser program () mempty t of
               Left _ -> Left PFFuckedUp -- Hides implementation details poorly.
               Right x -> Right x

rawParse :: Text -> Either ParseError Expression
rawParse t = runParser program () mempty =<< lex t

program :: ExpressionParser
program = anyLeft expression

expression :: ExpressionParser
expression = nothing
         <|> leftGroup
         <|> rightGroup
         <|> datum
         <|> code
         <|> try value
         <|> try symbol
         <?> "expression"

leftGroup :: ExpressionParser
leftGroup = char '(' *> anyLeft expression <* char ')'

rightGroup :: ExpressionParser
rightGroup = char '[' *> anyRight expression <* char ']'

datum :: ExpressionParser
datum = char '`' *> (ESomeData <$> expression)

code :: ExpressionParser
code = char ',' *> (ESomeCode <$> expression)

moreData :: ExpressionParser
moreData = fail "undefined"

moreCode :: ExpressionParser
moreCode = fail "undefined"

nodule :: ExpressionParser
nodule = fail "undefined"

value :: ExpressionParser
value = fail "undefined"

symbol :: ExpressionParser
symbol = undefined

nothing :: ExpressionParser
nothing = eof $> ESingleton

invisible :: ExpressionParser
invisible = oneOf "\a\b\t\n\v\f\r " $> undefined

-- Works.
-- runParser (anyRight (ESymbol . pack <$> string "f")) (initialPos "") "" "ffff"

anyLeft :: ExpressionParser -> ExpressionParser
anyLeft p = try (manyLeft p) <|> pure ESingleton

anyRight :: ExpressionParser -> ExpressionParser
anyRight p = try (manyRight p) <|> pure ESingleton

manyLeft :: ExpressionParser -> ExpressionParser
manyLeft p = try (flip EPair <$> p <*> manyLeft p) <|> pure ESingleton

manyRight :: ExpressionParser -> ExpressionParser
manyRight p = try (EPair <$> p <*> manyRight p) <|> pure ESingleton
