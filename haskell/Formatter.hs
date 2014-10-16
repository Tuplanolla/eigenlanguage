module Formatter (eigenformat, eigenformatIO, eigenserialize) where

import Common (Expression (..))

import System.Console.ANSI

{-
Something to put into a separate document:

Pretty printing should convert a parse tree into a form that
is as readable as possible.
It features formatting, spacing, indentation and line wrapping.
Restructuring and spell checking are out of its scope.
Prettiness or readability is difficult to define, but
based on the gathered data,
it seems that pretty code follows certain key points.
Assuming there is no format to begin with,

* regions without nesting should be separated into paragraphs,
* long lines should be split,
* splits should favor special forms and boundaries like ") (",
* indentation should go by common structures,
* the effect of name lengths on indentation should be minimized,
* excessively long indents should be crushed and
* all-encompassing top level parentheses should be left unindented.
-}

eigenformatIO :: Expression -> IO ()
eigenformatIO = formatIO 0 False

-- This entire thing is questionable.
formatIO :: Int -> Bool -> Expression -> IO ()
formatIO n _ (EPair (ESymbol "`") x) = unformatIO n True x
formatIO n True e @ (EPair _ _) = do with Red "("
                                     formatIO n False e
                                     with Red ")"
formatIO n _ (EPair x @ (EPair _ _)
                    y @ (EPair _ _)) = do formatIO n False x
                                          with White ('\n' : replicate (n + 3) ' ')
                                          formatIO (n + 3) True y
formatIO n _ (EPair x y) = do formatIO n False x
                              with White " "
                              formatIO n True y
formatIO n _ (ESymbol x @ "`") = with Green x
formatIO n _ (ESymbol x @ ",") = with Green x
formatIO n _ (ESymbol x @ "->") = with Yellow x
formatIO n _ (ESymbol x @ "=") = with Yellow x
formatIO n _ (ESymbol x) = with White x
formatIO n _ ENothing = with Magenta "()"
formatIO n _ (ELogical True) = with Magenta "true"
formatIO n _ (ELogical False) = with Magenta "false"
formatIO n _ (EInteger x) = with Magenta (show x)
formatIO n _ (ECharacter x) = with Blue (show x)

unformatIO :: Int -> Bool -> Expression -> IO ()
unformatIO n _ (EPair (ESymbol ",") x) = formatIO n True x
unformatIO n True x @ (EPair _ _) = do with Green "["
                                       unformatIO n False x
                                       with Green "]"
unformatIO n _ (EPair x ENothing) = unformatIO n False x
unformatIO n _ (EPair x y) = do unformatIO n False x
                                with White " "
                                unformatIO n False y
unformatIO n p x = formatIO n p x

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
unformat _ (EPair (ESymbol ",") x) = format True x
unformat True x @ (EPair _ _) = "[" ++ unformat False x ++ "]"
unformat _ (EPair x ENothing) = unformat False x
unformat _ (EPair x y) = unformat False x ++ " " ++ unformat False y
unformat p x = format p x
