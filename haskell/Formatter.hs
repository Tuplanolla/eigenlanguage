module Formatter where

import Data.Text
import Data.Text.IO
import Prelude hiding (putStr)
import System.Console.ANSI

import Common

{-
Some ideas on representing concrete syntax trees.
One needs to take the abstract bullshit and
tag it with indentation, line breaking and color.
-}

type AList a b = [(a, b)]

data Augmented a b = APart a b APart
                   | AEnd
                   deriving Show

data Colored a = CPart Color a CPart
               | CEnd
               deriving Show

data Indented a = IPart Integer a IPart
                | IEnd
                deriving Show

present :: Expression -> Presentation
present = undefined

{-
color :: Piece -> Color
color Symbol = White
color Literal = Magenta
color Form = Yellow
color LeftGroup = Red
color RightGroup = Green

-- putPresentation $ Code Red (pack "(") $ Code Yellow (pack "+") $ Code White (pack " ") $ Code Magenta (pack "2") $ Code White (pack " ") $ Code Magenta (pack "3") $ Code Red (pack ")") $ Code White (pack "\n") End

putPresentation :: Presentation -> IO ()
putPresentation (Code c t f) = do setSGR [SetColor Foreground Vivid c,
                                          SetConsoleIntensity BoldIntensity]
                                  putStr t
                                  putPresentation f
putPresentation End = setSGR [Reset]
-}
