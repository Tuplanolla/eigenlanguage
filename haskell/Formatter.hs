module Formatter (eigenformat) where

import Common (Expression (..))

eigensubformat :: Expression -> String
eigensubformat = format True

eigenformat :: Expression -> String
eigenformat = format False

-- This should use less packing and more line breaking.
format :: Bool -> Expression -> String
format _ (EPair (ESymbol "`") x) = "`" ++ eigensubformat x
format _ (EPair (ESymbol ",") x) = "," ++ eigensubformat x
format True p @ (EPair _ _) = "(" ++ eigenformat p ++ ")"
format _ (EPair x y) = eigenformat x ++ " " ++ eigensubformat y
format _ (ESymbol x) = x
--
format _ ENothing = "()"
format _ (EUnique x) = show x
format _ (EInteger x) = show x
format _ (ECharacter x) = show x
