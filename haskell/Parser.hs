{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Data.Map
import Data.Monoid
import Data.Text.Lazy hiding (singleton)
import Prelude hiding (lex)
import Text.Parsec hiding (parse)
import Text.Parsec.Prim hiding (parse)
import Text.Parsec.Pos

import Data
import Formatter -- No.
import Lexer

($>) :: Functor f => f a -> b -> f b
($>) = flip (<$)
infixl 4 $>

tagPos :: SourcePos -> Expression -> Expression
tagPos sp = ETag (TFilePath (sourceName sp))
          . ETag (TLineNumber (sourceLine sp))
          . ETag (TColumnNumber (sourceColumn sp))

-- And now for some trash that does not compile...

{-
parse :: [Lexeme] -> Either ParseFailure Expression
parse t = case runParser program () mempty t of
               Left _ -> Left PFFuckedUp -- Hides implementation details poorly.
               Right x -> Right x
-}
parse = runParser program () mempty

rawParse :: Text -> Either ParseError Expression
rawParse t = runParser program () mempty =<< lex t

type ExpressionParser = Parsec [Lexeme] ({- State -}) Expression

program :: ExpressionParser
program = anyLeft expression

expression :: ExpressionParser
expression = leftGroup
             <|> rightGroup
             <|> datum
             <|> code
             <|> value
             <|> symbol
             <?> "expression"

leftGroup :: ExpressionParser
leftGroup = the LLeftOpen *> anyLeft expression <* the LLeftClose

rightGroup :: ExpressionParser
rightGroup = the LRightOpen *> anyRight expression <* the LRightClose

datum :: ExpressionParser
datum = the LData *> (ESomeData <$> expression)

code :: ExpressionParser
code = the LCode *> (ESomeCode <$> expression)

nodule :: ExpressionParser
nodule = fail "undefined"

value :: ExpressionParser
value = EInteger . getInteger <$> thePrim isInteger
        <|> ECharacter . getCharacter <$> thePrim isCharacter

symbol :: ExpressionParser
symbol = ESymbol . getSymbol <$> thePrim isSymbol

getSymbol (LSymbol s) = s
getInteger (LInteger x) = x
getCharacter (LCharacter c) = c
getString (LString s) = s

isSymbol (LSymbol _) = True
isSymbol _ = False
isInteger (LInteger _) = True
isInteger _ = False
isCharacter (LCharacter _) = True
isCharacter _ = False
isComment (LBlockComment _) = True
isComment (LLineComment _) = True
isComment _ = False

-- the :: Lexeme -> Parser Lexeme
-- the l = satisfy (== l) <?> show (l :: Lexeme)

the :: (Show a, Eq a) => a -> Parsec [a] () a
the x = thePrim (== x)

thePrim :: Show a => (a -> Bool) -> Parsec [a] () a
thePrim f = let g x | f x = Just x
                    | otherwise = Nothing
                h n _ _ = incSourceColumn n 1 in
                tokenPrim show h g

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
