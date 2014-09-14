module Parser where

import Control.Applicative hiding ((<|>), many)
import Text.Parsec.Char
import Text.Parsec.Combinator
import Text.Parsec.Error
import Text.Parsec.Expr
import Text.Parsec.Language
import Text.Parsec.Perm
import Text.Parsec.Pos
import Text.Parsec.Prim
import Text.Parsec.String
import Text.Parsec.Token

import Core

import Evaluator -- bad
import Example -- bad
-- and the rest is even worse

testBoth :: String -> Either ParseError E
testBoth s = evaluate systemEnv <$> testParse s

testEvaluate :: E -> E
testEvaluate = evaluate systemEnv

testParse :: String -> Either ParseError E
testParse = parse parseE "test"

parseE :: Parser E
parseE = do xs <- try parseF <|> try parseB <|> parseA
            return xs

parseA :: Parser E
parseA = do xs <- many1 (parseW *> parseU)
            parseW
            return (foldr1 (flip A) (reverse xs)) -- shit

parseF :: Parser E
parseF = do string "->"
            xs <- parseW *> parseWhat
            parseW
            ys <- parseU
            return (F (\ x -> B [(xs, x)] ys)) -- wrong

parseB :: Parser E
parseB = do string "="
            xys <- many (try $ do q <- parseW *> parseWhat
                                  m <- parseW *> parseU
                                  return (q, m))
            parseW
            zs <- parseU
            return (B xys zs) -- disgusting

parseU :: Parser E
parseU = do x <- parseG parseE <|> parseR <|> parseV -- dubious
            return x

parseG :: Parser E -> Parser E
parseG p = do char '('
              parseW
              xs <- p
              parseW
              char ')'
              parseW
              return xs

parseV :: Parser E
parseV = do x <- parseC <|> parseS <|> parseI
            return x

parseR :: Parser E
parseR = do x <- parseWhat
            return (R x)

parseI :: Parser E
parseI = do xs <- integer haskell
            return (I xs)

parseC :: Parser E
parseC = do char '\''
            xs <- parseSpecialC <|> parseLiteralC
            char '\''
            return xs

parseSpecialC :: Parser E
parseSpecialC = do
 char '\\'
 xs <- many1 (letter <|> digit)
 return $ case xs of
        "t" -> C '\t'
        "n" -> C '\n'
        [x] -> C x

parseLiteralC :: Parser E
parseLiteralC = do
 xs <- many1 (letter <|> digit)
 return $ case xs of
        [x] -> C x

parseS :: Parser E
parseS = do char '"'
            xs <- many (noneOf ['\\', '"'])
            char '"'
            return (S xs)

parseWhat :: Parser String
parseWhat = do x <- identStart haskellDef <|> opStart haskellDef
               xs <- many (identLetter haskellDef <|> opLetter haskellDef)
               return (x : xs)

parseW :: Parser ()
parseW = whiteSpace haskell -- no

{- e0ba78_16 -}

{-
parseDecimal :: Parser E
parseDecimal = do char 'd'
                  n <- many1 digit
                  (return . Number . read) n

parseRatio :: Parser E
parseRatio = do num <- fmap read $ many1 digit
                char '/'
                denom <- fmap read $ many1 digit
                (return . Ratio) (num % denom)

parseFloat :: Parser E
parseFloat = do whole <- many1 digit
                char '.'
                decimal <- many1 digit
                return $ Float (read (whole++"."++decimal))

parseComplex :: Parser E
parseComplex = do r <- fmap toDouble (try parseFloat <|> parsePlainNumber)
                  char '+'
                  i <- fmap toDouble (try parseFloat <|> parsePlainNumber)
                  char 'i'
                  (return . Complex) (r :+ i)
               where toDouble (Float x) = x
                     toDouble (Number x) = fromIntegral x
-}
