module Formatter where

import Parser

formatWrapped :: Parse -> String
formatWrapped = format True

formatUnwrapped :: Parse -> String
formatUnwrapped = format False

format :: Bool -> Parse -> String
format _ PComment = ""
format _ (PPack x) = "`" ++ formatWrapped x
format _ (PUnpack x) = "," ++ formatWrapped x
format True p @ (PApply _ _) = "(" ++ formatUnwrapped p ++ ")"
format _ (PApply f x) = let x @ (_ : _) +++ y @ (_ : _) = x ++ " " ++ y
                            x +++ y = x ++ y in
                            formatUnwrapped f +++ formatWrapped x
format _ (PSymbol x) = x
format _ PNothing = "()"
format _ (PInteger x) = show x
format _ (PCharacter x) = show x
format _ (PString x) = show x
