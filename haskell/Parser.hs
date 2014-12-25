{-# LANGUAGE OverloadedStrings #-} -- Useless for now.

-- | Converting source code into expressions.
module Parser where

import Control.Applicative ((<$>), (<*>), (*>), (<*), (<$), pure)
import Control.Monad
import Data.Char
import Data.Map hiding (foldl, foldr, singleton)
import Data.Monoid
import Data.Sequence hiding (length, singleton)
import Data.Text.Lazy hiding (concat, foldl, foldr, group, head, length)
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

withState p = flip (,) <$> p <*> getState

warn :: Location Warning -> StatefulParser ()
warn = modifyState . flip (|>)

warnHere :: ParseWarning -> StatefulParser ()
warnHere w = getPosition >>= warn . f
 where f p = LLocation (sourceName p) (sourceLine p) (sourceColumn p) (WParse w)

rawParse :: Code -> Either ParseError (ParserState, Tree Parse)
rawParse = runParser (withState program) Data.Sequence.empty "<interactive>" . strip

mediumParse :: StatefulParser (Tree Parse) -> Code -> Either ParseError (ParserState, Tree Parse)
mediumParse p = runParser (withState p) Data.Sequence.empty "<interactive>"

program :: StatefulParser (Tree Parse)
program = dirtyTrick <$> (group foldl <* eof)
 where dirtyTrick (TPair (TElement PSingleton) x) = x
       dirtyTrick x = x

-- This is terrible and dies to corner cases like "e%x(press ion)% comment".
expression :: StatefulParser (Tree Parse)
expression = pleaseNoInvisible *> expression
             <|> pleaseNoIllegal *> expression
             <|> TPair . TElement . PSymbol . singleton <$> char '`' <*> expression
             <|> TPair . TElement . PSymbol . singleton <$> char ',' <*> expression
             <|> between (char '(') (pleaseFixI (char ')')) (pleaseFixI (group foldl))
             <|> between (char '[') (pleaseFixI (char ']')) (pleaseFixI (group foldr))
             <|> char '%' *> (TElement . PLineComment
                                       . pack <$> (char ' ' *> to end
                                                   <|> mempty <$ end
                                                   <?> "end of line")
                              <|> TElement . PBlockComment
                                           . pack
                                  <$> (char '%' *> past (string "%%"))
                              <|> TPair (TElement (PSymbol "%")) <$> expression
                              <?> "end of comment")
             <|> TElement . PCharacter . characterify <$> (char '\'' *> past (char '\''))
             <|> TElement . PString . stringify <$> (char '"' *> past (char '"'))
             <|> TElement <$> try symbol

-- | Convert the name of a character into an actual character.
characterify :: String -> Char
characterify = head

-- | Convert escape sequences into characters.
-- Should put this into the main parser.
stringify :: String -> String
stringify s = case runParser escapist () [] s of
                   Left _ -> error "wrong, dead"
                   Right s -> s

escapist = mempty <$ eof
           <|> (:) '%' <$ try (string "%%")
                       <*> escapist
           -- The same as lowercase hexDigit.
           <|> (:) . chr . read . ("0x" ++) <$> join between (char '%') (many1 (oneOf (['0' .. '9'] ++ ['a' .. 'f'])))
                                            <*> escapist
           <|> (:) <$> anyChar
                   <*> escapist

notExactly = noneOf . pure

end = () <$ endOfLine <|> eof

to = manyTill anyChar . lookAhead

past = manyTill anyToken . try

pleaseNoInvisible = PWUnexpectedSpaces . length <$> many1 invisible >>= warnHere

pleaseNoIllegal = PWIllegalCharacter <$> forbidden >>= warnHere

pleaseFixI p = try (pleaseNoInvisible *> pleaseFixI p) <|> p

pleaseFix n p = try (n *> pleaseFix n p) <|> p

-- Should use sepBy here.
group f = f TPair (TElement PSingleton) <$> sepEndBy expression (pleaseFixI invisible)

forbidden :: StatefulParser Char
forbidden = oneOf "¤\0" -- The first one is for testing.

invisible :: StatefulParser Char
invisible = oneOf "\t\n\r "

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
