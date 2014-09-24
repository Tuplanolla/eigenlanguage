module Formatter (eigenformat) where

import Common

eigensubformat :: Expression -> String
eigensubformat = format True

eigenformat :: Expression -> String
eigenformat = format False

-- This should use less packing and more line breaking.
format :: Bool -> Expression -> String
format _ (EApply (ESymbol "`") x) = "`" ++ eigensubformat x
format _ (EApply (ESymbol ",") x) = "," ++ eigensubformat x
format True p @ (EApply _ _) = "(" ++ eigenformat p ++ ")"
format _ (EApply f x) = eigenformat f ++ " " ++ eigensubformat x
format _ (ESymbol x) = x
--
format _ ENothing = "()"
format _ (EInteger x) = show x
format _ (ECharacter x) = show x
format _ (EPair x y) = "`(," ++ eigenformat x ++ " ," ++ eigenformat y ++ ")"
