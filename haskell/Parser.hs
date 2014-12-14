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

program :: ParserPos Expression
program = expression

expression :: ParserPos Expression
expression = nothing
         <|> try leftGroup
         <|> try rightGroup
         <|> try someData
         <|> try someCode
         <|> try moreData
         <|> try moreCode
         <|> try nodule
         <|> try function
         <|> try binding
         <|> try value
         <|> try symbol
         <|> anySpace *> expression

leftGroup :: ParserPos Expression
leftGroup = string "(" *> anyLeft expression <* string ")"

rightGroup :: ParserPos Expression
rightGroup = string "[" *> anyRight expression <* string "]"

someData :: ParserPos Expression
someData = string "`" *> (ESomeData <$> expression)

someCode :: ParserPos Expression
someCode = string "`" *> (ESomeCode <$> expression)

moreData :: ParserPos Expression
moreData = fail "undefined"

moreCode :: ParserPos Expression
moreCode = fail "undefined"

nodule :: ParserPos Expression
nodule = fail "undefined"

-- Works by accident.
-- let f (ERightArrow g) = g in flip f (ELogical True) <$> rawParse "->x x"

function :: ParserPos Expression
function = tagPos <$> getState
       <*> (string "->" *> ((\ f b -> ERightArrow
       (\ x -> EEquality (fromList [(unsafeExtractSymbol f, x)]) b))
       <$> functionForm <*> functionBody))

unsafeExtractSymbol :: Expression -> Symbol
unsafeExtractSymbol (ESymbol s) = s
unsafeExtractSymbol _ = error "not a symbol"

functionForm :: ParserPos Expression
functionForm = try functionParameter
           <|> try functionParameterList

functionParameterList :: ParserPos Expression
functionParameterList = string "(" *> functionParameter <* string ")"

functionParameter :: ParserPos Expression
functionParameter = symbol

functionBody :: ParserPos Expression
functionBody = expression

binding :: ParserPos Expression
binding = fail "undefined"

value :: ParserPos Expression
value = fail "undefined"

symbol :: ParserPos Expression
symbol = ESymbol . pack <$> many1 (oneOf (chr <$> [0x41 .. 0x5a] ++ [0x61 .. 0x7a]))

nothing :: ParserPos Expression
nothing = eof $> ESingleton

anySpace :: ParserPos ()
anySpace = oneOf "\a\b\t\n\v\f\r " $> ()

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
