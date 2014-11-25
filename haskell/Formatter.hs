module Formatter where

import Data.Text
import Data.Text.IO
import Prelude hiding (putStr)
import System.Console.ANSI
import System.IO

import Data

tag :: Expression -> Expression
tag = undefined

format :: Expression -> String
format = undefined

display :: Expression -> IO ()
display = undefined

hDisplay :: Handle -> Expression -> IO ()
hDisplay = undefined

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
