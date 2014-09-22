module Evaluator where

import Control.Applicative
import Control.Monad
import Data.Functor
import Data.Map

import Core

systemEnv :: [(String, E)]
systemEnv = [("-", liftInteger2 (-)),
             ("*", liftInteger2 (*)),
             ("+", liftInteger2 (+)),
             ("true", L True),
             ("false", L False),
             ("always", liftAlways),
             ("if", liftIf),
             ("<", liftIntegerPredicate (<))
             -- , ("evaluate", liftInteger2 (evaluate))
             ]

getInteger :: E -> Integer
getInteger (I x) = x
getInteger _ = error "not an integer"

getLogical :: E -> Bool
getLogical (L x) = x
getLogical _ = error "not a logical"

liftInteger :: (Integer -> Integer) -> E
liftInteger f = let run = getInteger . evaluate [] in
                    F (\ x -> I (f (run x)))

liftInteger2 :: (Integer -> Integer -> Integer) -> E
liftInteger2 f = let run = getInteger . evaluate [] in
                     F (\ x -> F (\ y -> I (f (run x) (run y))))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> E
liftInteger3 f = let run = getInteger . evaluate [] in
                     F (\ x -> F (\ y -> F (\ z -> I (f (run x) (run y) (run z)))))

liftIntegerPredicate :: (Integer -> Integer -> Bool) -> E
liftIntegerPredicate f = let run = getInteger . evaluate [] in
                             F (\ x -> F (\ y -> L (f (run x) (run y))))

liftAlways :: E
liftAlways = F (\ x -> F (\ y -> x))

liftIf :: E
liftIf = let run = getLogical . evaluate [] in
             F (\ x -> F (\ y -> F (\ z -> if run x then y else z)))

evaluate :: [(String, E)] -> E -> E
evaluate b (F f) = F (evaluate b . f)
evaluate b (A f x) = apply (evaluate b f) (evaluate b x)
evaluate b (B e x) = let recur (y, z) = (y, evaluate b (B e z)) in
                         evaluate ((recur <$> e) ++ b) x -- assoc
-- evaluate b (B e x) = evaluate (e ++ b) x -- assoc
evaluate b (R k) = fetch k b (get k b)
evaluate b e = e

apply :: E -> E -> E
apply (F f) x = f x
apply f _ = error ("not a function: " ++ show f)

fetch k b (Just v) = v
fetch k b _ = error ("not a name: " ++ k ++ "\nin: " ++ show b)

assoc :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
assoc k v xs = (k, v) : filter ((k /=) . fst) xs

get :: Eq a => a -> [(a, b)] -> Maybe b
get k ((x, y) : xys) | k == x = Just y
                     | otherwise = lookup k xys
get _ _ = Nothing
