module Formatter (eigenformat, eigenformatIO, eigenserialize) where

import Common (Expression (..))

import System.Console.ANSI

eigenformatIO :: Expression -> IO ()
eigenformatIO = formatIO False

-- This entire thing is questionable.
formatIO :: Bool -> Expression -> IO ()
formatIO True e @ (EPair _ _) = do with Red "("
                                   formatIO False e
                                   with Red ")"
formatIO _ (EPair x y) = do formatIO False x
                            with White " "
                            formatIO True y
formatIO _ (ESymbol x @ "`") = with Green x
formatIO _ (ESymbol x @ ",") = with Green x
formatIO _ (ESymbol x @ "->") = with Yellow x
formatIO _ (ESymbol x @ "<-") = with Yellow x
formatIO _ (ESymbol x) = with White x
formatIO _ ENothing = with Magenta "()"
formatIO _ (ELogical True) = with Magenta "true"
formatIO _ (ELogical False) = with Magenta "false"
formatIO _ (EInteger x) = with Magenta (show x)
formatIO _ (ECharacter x) = with Blue (show x)

with :: Color -> String -> IO ()
with c x = do setSGR [SetColor Foreground Vivid c,
                      SetConsoleIntensity (if c == White then
                                              NormalIntensity else
                                              BoldIntensity)]
              putStr x
              setSGR [Reset]

-- Perhaps this should work with Structure instead of Expression.
eigenformat :: Expression -> String
eigenformat = eigenserialize -- Line breaks go here.

eigenserialize :: Expression -> String
eigenserialize = format False

format :: Bool -> Expression -> String
format _ (EPair (ESymbol "`") x) = unformat True x
format True e @ (EPair _ _) = "(" ++ format False e ++ ")"
format _ (EPair x y) = format False x ++ " " ++ format True y
format _ (ESymbol x) = x
format _ ENothing = "()"
-- The rest is questionable.
format _ (ELogical True) = "true"
format _ (ELogical False) = "false"
format _ (EInteger x) = show x
format _ (ECharacter x) = show x
format _ (EUnique x) = show x
format _ (EEffect x) = show x
format _ (EFunction x) = show x
format _ (EBind x y) = show x ++ " " ++ show y
format _ (EArray x) = show x

unformat :: Bool -> Expression -> String
unformat _ (EPair (ESymbol ",") x) = "," ++ format True x
unformat True x @ (EPair _ _) = "[" ++ unformat False x ++ "]"
unformat _ (EPair x ENothing) = unformat False x
unformat _ (EPair x y) = unformat False x ++ " " ++ unformat False y
unformat p x = format p x
