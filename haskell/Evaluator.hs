module Evaluator where

import Control.Applicative hiding (empty)
import Control.Monad
import Data.Functor
import Data.IORef
-- Hide environment manipulation behind a type class?
import Data.Map (Map, empty, fromList, insert, lookup, singleton, union)
import Prelude hiding (lookup)

import Common
import Parser

eigenevaluate :: Expression -> Expression
eigenevaluate = evaluate systemEnv

-- This is "the simplest that works", but may be stupid and do unnecessary work.
evaluate :: Environment -> Expression -> Expression
evaluate e (EPair (ESymbol "`") x) = unevaluate e x
evaluate e (EPair (EPair (ESymbol "->")
                         (ESymbol k)) x)
         = let f v = evaluate e (EBind (singleton k v) x) in
               EFunction f
evaluate e (EPair (EPair (ESymbol "->")
                         (EPair (ESymbol k) x)) y)
         = let f v = evaluate e (EPair (EPair (ESymbol "->") x)
                                       (EBind (singleton k v) y)) in
               EFunction f -- Fold here instead?
evaluate e (EPair (EPair (ESymbol "=") b) x) = evaluate e (EBind (fold b) x)
evaluate e (EPair x y) = apply (evaluate e x) (evaluate e y)
evaluate e (ESymbol k) = fetch e k (lookup k e)
evaluate e (EFunction f) = EFunction (evaluate e . f)
evaluate e (EBind b x) = evaluate (union (propagate e b) e) x
evaluate e (EEffect x) = EEffect (evaluate e <$> x)
evaluate e x = x

unevaluate :: Environment -> Expression -> Expression
unevaluate e (EPair (ESymbol ",") x) = evaluate e x
unevaluate e (EPair f x) = EPair (unevaluate e f) (unevaluate e x)
unevaluate e x = x

-- Implement Foldable instead?
fold :: Expression -> Environment
fold (EPair (EPair x (ESymbol k)) v) = insert k v (fold x)
fold (EPair (ESymbol k) v) = singleton k v

-- Abstract something else instead?
propagate :: Environment -> Environment -> Environment
propagate e b = evaluate e . EBind b <$> b

apply :: Expression -> Expression -> Expression
apply (EFunction f) y = f y
apply x _ = error ("not a function: " ++ show x)

fetch e k (Just v) = v
fetch e k _ = error ("not a name: " ++ show k ++ " in " ++ show e)

systemEnv :: Environment
systemEnv = fromList [("-", liftInteger2 (-)),
                      ("*", liftInteger2 (*)),
                      ("+", liftInteger2 (+)),
                      ("true", ELogical True),
                      ("false", ELogical False),
                      ("always", liftAlways),
                      ("if", liftIf),
                      ("<", liftIntegerPredicate (<)),
                      ("head", liftHead),
                      ("tail", liftTail),
                      ("evaluate", liftEvaluate),
                      ("io", EEffect (EUnique <$> newIORef True)),
                      ("print-character", liftPC putChar)]

touch :: IO () -> IORef Bool -> IO (IORef Bool)
touch a r = do x <- readIORef r
               if x then
                    do writeIORef r False
                       _ <- a
                       r <- newIORef True
                       return r else
                    error "not a valid reference"

liftPC :: (Char -> IO ()) -> Expression
liftPC f = let run = getCharacter . evaluate empty
               run' = (getUnique <$>) . getEffect . evaluate empty in
               EFunction (\ x -> EFunction (\ y -> EEffect $ EUnique <$> (touch (f $ run x) =<< (run' y))))

liftIf :: Expression
liftIf = let run = getLogical . evaluate empty in
             EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> if run x then y else z)))

liftAlways :: Expression
liftAlways = EFunction (\ x -> EFunction (\ y -> x))

liftEvaluate :: Expression
liftEvaluate = EFunction eigenevaluate

liftHead :: Expression
liftHead = let f (EPair x y) = x in
               EFunction f

liftTail :: Expression
liftTail = let f (EPair x y) = y in
               EFunction f

-- The rest is automatically generated.

getEffect :: Expression -> IO Expression
getEffect (EEffect x) = x
getEffect x = error ("not an effect: " ++ show x)

getUnique :: Expression -> IORef Bool
getUnique (EUnique x) = x
getUnique x = error ("not a unique type: " ++ show x)

getInteger :: Expression -> Integer
getInteger (EInteger x) = x
getInteger x = error ("not an integer: " ++ show x)

getLogical :: Expression -> Bool
getLogical (ELogical x) = x
getLogical x = error ("not a logical: " ++ show x)

getCharacter :: Expression -> Char
getCharacter (ECharacter x) = x
getCharacter x = error ("not a character: " ++ show x)

liftInteger :: (Integer -> Integer) -> Expression
liftInteger f = let run = getInteger . evaluate empty in
                    EFunction (\ x -> EInteger (f (run x)))

liftInteger2 :: (Integer -> Integer -> Integer) -> Expression
liftInteger2 f = let run = getInteger . evaluate empty in
                     EFunction (\ x -> EFunction (\ y -> EInteger (f (run x) (run y))))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> Expression
liftInteger3 f = let run = getInteger . evaluate empty in
                     EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> EInteger (f (run x) (run y) (run z)))))

liftIntegerPredicate :: (Integer -> Integer -> Bool) -> Expression
liftIntegerPredicate f = let run = getInteger . evaluate empty in
                             EFunction (\ x -> EFunction (\ y -> ELogical (f (run x) (run y))))

putLn :: IO ()
putLn = putStrLn ""
