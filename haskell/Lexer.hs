-- | Splitting source code into manageable pieces.
module Lexer where

import Control.Applicative hiding ((<|>), many)
import Data.Monoid
import Data.Text.Lazy hiding (concat, head, length)
import Text.Parsec
import Text.Parsec.Pos
import Text.Parsec.Prim
import Text.Parsec.Text.Lazy

import Data hiding (ParseError)

data Lexeme = LLeftOpen
            | LLeftClose
            | LRightOpen
            | LRightClose
            | LData
            | LCode
            | LComment
            | LLineComment Code
            | LBlockComment Code
            | LSymbol Code
            | LSpace Nat
            | LLineBreak Nat
            | LInteger Integer
            | LCharacter Char
            | LString String
            deriving (Eq, Show)

lex :: Code -> Either ParseError [Lexeme]
lex = runParser (many lexeme) () mempty

-- Some backtracking and line breaking corner cases are still left to fix.
lexeme :: Parser Lexeme
lexeme = LLeftOpen <$ char '('
         <|> LLeftClose <$ char ')'
         <|> LRightOpen <$ char '['
         <|> LRightClose <$ char ']'
         <|> LData <$ char '`'
         <|> LCode <$ char ','
         <|> char '%' *> (LLineComment . pack <$> (char ' ' *> to end
                                                   <|> mempty <$ end
                                                   <?> "end of line")
                          <|> LBlockComment . pack <$> (char '%' *> past (try (string "%%")))
                          <|> pure LComment
                          <?> "end of comment")
         <|> LInteger . read <$> try (many1 digit)
         <|> LCharacter . head <$> (char '\'' *> escaped <* char '\'')
         <|> LString <$> (char '"' *> escaped <* char '"')
         <|> LSymbol . pack <$> ((:) <$> noneOf "()[]`,% \n\r\'\""
                                     <*> many (noneOf "()[]`,% \n\r"))
         <|> LSpace . fromIntegral . length <$> many1 (char ' ')
         <|> LLineBreak . fromIntegral . length <$> many1 eol
         <?> "lexeme"

escaped :: Parser String
escaped = concat <$> many thing

thing :: Parser String
thing = pure <$> nonEscape <|> escape

escape :: Parser String
escape = (\ x y -> [x, y]) <$> char '\\' <*> oneOf "\\\"'0nrt"

nonEscape :: Parser Char
nonEscape = noneOf "\\\"'\0\n\r\f"

to :: GenParser a b -> GenParser a String
to = manyTill anyChar . lookAhead

past :: GenParser a b -> GenParser a String
past = manyTill anyToken . try

end :: GenParser a ()
end = eol <|> eof <?> "end of line or input"

eol :: GenParser a ()
eol = () <$ endOfLine
