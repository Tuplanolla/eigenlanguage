module Core where

import Text.Show.Functions ()

{-
import Data.Map

data Expression = EFunction (Expression -> Expression)
                | EApplication Expression Expression
                | EBinding (Map String Expression) Expression
                | ESymbol String
                | EPair Expression Expression
                --
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | EString String
                deriving Show
-}

data E = L Bool -- Logical
       | I Integer -- Integer
       | C Char -- Character
       | S String -- String
       | F (E -> E) -- Function
       | A E E -- Application
       | B [(String, E)] E -- Binding
       | R String -- Reference
       deriving Show -- Expression

wrapIf :: Bool -> String -> String
wrapIf True x = "(" ++ x ++ ")"
wrapIf _ x = x

showNicely :: Bool -> E -> String -- terrible
showNicely p (L True) = "true"
showNicely p (L False) = "false"
showNicely p (I x) = show x
showNicely p (C x) = show x
showNicely p (S x) = show x
showNicely p (F x) = wrapIf p $ "-> ?x " ++ showNicely True (x (R "?x"))
showNicely p (A x y) = wrapIf p $ showNicely False x ++ " " ++ showNicely True y
showNicely p (B e x) = wrapIf p $ "=" ++ foldr (\ (k, v) y -> " " ++ k ++ " " ++ showNicely True v ++ y) "" e ++ " " ++ showNicely True x
showNicely p (R x) = x
