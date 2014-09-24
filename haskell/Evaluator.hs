module Evaluator where

import Control.Applicative
import Control.Monad
import Data.Array (Array)
import Data.Functor
import Data.Map (Map)
import Text.Show.Functions ()

import Common
import Parser

eigenevaluate :: Expression -> Expression
eigenevaluate = evaluate systemEnv

evaluate :: Environment -> Expression -> Expression
evaluate b (EFunction f) = EFunction (evaluate b . f)
evaluate b (EApply f x) = apply (evaluate b f) (evaluate b x)
evaluate b (EBind e x) = let recur (y, z) = (y, evaluate b (EBind e z)) in
                         evaluate ((recur <$> e) ++ b) x -- assoc
-- evaluate b (EBind e x) = evaluate (e ++ b) x -- assoc
evaluate b (ESymbol k) = fetch k b (get k b)
evaluate b e = e

apply :: Expression -> Expression -> Expression
apply (EFunction f) x = f x
apply f _ = error ("not a function: " ++ show f)

fetch k b (Just v) = v
fetch k b _ = error ("not a name: " ++ k ++ "\nin: " ++ show b)

assoc :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
assoc k v xs = (k, v) : filter ((k /=) . fst) xs

get :: Eq a => a -> [(a, b)] -> Maybe b
get k ((x, y) : xys) | k == x = Just y
                     | otherwise = lookup k xys
get _ _ = Nothing

systemEnv :: [(String, Expression)]
systemEnv = [("-", liftInteger2 (-)),
             ("*", liftInteger2 (*)),
             ("+", liftInteger2 (+)),
             ("true", ELogical True),
             ("false", ELogical False),
             ("always", liftAlways),
             ("if", liftIf),
             ("<", liftIntegerPredicate (<))
             -- , ("evaluate", liftInteger2 (evaluate))
             ]

getInteger :: Expression -> Integer
getInteger (EInteger x) = x
getInteger _ = error "not an integer"

getLogical :: Expression -> Bool
getLogical (ELogical x) = x
getLogical _ = error "not a logical"

liftInteger :: (Integer -> Integer) -> Expression
liftInteger f = let run = getInteger . evaluate [] in
                    EFunction (\ x -> EInteger (f (run x)))

liftInteger2 :: (Integer -> Integer -> Integer) -> Expression
liftInteger2 f = let run = getInteger . evaluate [] in
                     EFunction (\ x -> EFunction (\ y -> EInteger (f (run x) (run y))))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> Expression
liftInteger3 f = let run = getInteger . evaluate [] in
                     EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> EInteger (f (run x) (run y) (run z)))))

liftIntegerPredicate :: (Integer -> Integer -> Bool) -> Expression
liftIntegerPredicate f = let run = getInteger . evaluate [] in
                             EFunction (\ x -> EFunction (\ y -> ELogical (f (run x) (run y))))

liftAlways :: Expression
liftAlways = EFunction (\ x -> EFunction (\ y -> x))

liftIf :: Expression
liftIf = let run = getLogical . evaluate [] in
             EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> if run x then y else z)))
