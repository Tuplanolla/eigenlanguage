module Evaluator where

import Control.Applicative
import Control.Monad
import Data.Functor

import Core

getInteger :: E -> Integer
getInteger (I x) = x
getInteger _ = error "not an integer"

liftInteger :: (Integer -> Integer) -> E
liftInteger f = let run = getInteger . evaluate [] in
                    F (\ x -> I (f (run x)))

liftInteger2 :: (Integer -> Integer -> Integer) -> E
liftInteger2 f = let run = getInteger . evaluate [] in
                     F (\ x -> F (\ y -> I (f (run x) (run y))))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> E
liftInteger3 f = let run = getInteger . evaluate [] in
                     F (\ x -> F (\ y -> F (\ z -> I (f (run x) (run y) (run z)))))

evaluate :: [(String, E)] -> E -> E
evaluate b (F f) = F (evaluate b . f)
evaluate b (A f x) = apply (evaluate b f) (evaluate b x)
evaluate b (B e x) = evaluate (e ++ b) x -- assoc
evaluate b (R k) = fetch (get k b)
evaluate b e = e

apply :: E -> E -> E
apply (F f) x = f x
apply f _ = error ("not a function: " ++ show f)

fetch (Just k) = k
fetch _ = error ("not a name: " ++ "??")

assoc :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
assoc k v xs = (k, v) : filter ((k /=) . fst) xs

get :: Eq a => a -> [(a, b)] -> Maybe b
get k ((x, y) : xys) | k == x = Just y
                     | otherwise = lookup k xys
get _ _ = Nothing

{-
instance Functor E where
 fmap f (V x) = V (f x)
 fmap f e @ (F g) = fmap f g
 fmap :: (a -> b) -> E a -> E b
 f :: a -> b
 F g :: E a
 g :: E a -> E a
 fmap f (A g x) = A (f . g) x
-}

{-
(+ (+ 1 2)
   (<- (x 3)
       (+ x (<- (f +-)
                (f 4)))))

A (A (f2 (+)) (A (A (f2 (+)) (V 1)) (V 2)))
  (B "x" (V 3)
     (A (A (f2 (+)) (S "x")) (B "f" (f1 negate)
                                (A "f" (S "x")))))

f1 :: (a -> a) -> E a -> E a
f1 f x = f <$> x

f2 :: (a -> a -> a) -> E a -> E a -> E a
f2 f x y = f <$> x <*> y

apply :: E a -> E a -> E a
apply (F f) x = f x
apply e x = error "nope"

evaluate :: E a -> E a
evaluate e @ (V _) = e
evaluate e @ (F _) = e
evaluate (A f x) = apply (evaluate f) (evaluate x)
evaluate (B k v x) = evaluate x
evaluate (S k) = error $ "free " ++ show k

extract :: E a -> a
extract (V x) = x
extract _ = error "not a value"

assoc :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
assoc k v xs = (k, v) : filter ((k /=) . fst) xs
-}

{-
evaluate :: E a -> a
evaluate (V x) = x
evaluate (A (F f) x) = evaluate (f (evaluate x))
evaluate (A f x) = evaluate x
evaluate (B k v x) = evaluate x
evaluate (S k) = bindError k

evaluate :: Num a => E a -> [(String, a)] -> a
evaluate (V x) = pure $ pure x
evaluate (F f) = evaluate (V f)
evaluate (A f x) = liftA2 <$> (+) <*> evaluate x
evaluate (B x y z) = evaluate z . assoc x y
evaluate (S x) = pure . fromMaybe (bindError x) . lookup x

bindError :: String -> a
bindError x = error $ "undefined variable '" ++ x ++ "'"

evaluate :: Floating a => Expression a -> [(String, a)] -> [a]
-- This unholy contraption took an hour to craft.
evaluate (Branch x fs)      = pure ( join
                                   . liftA ( (evaluate_ =<<)
                                           . flip fmap fs
                                           . flip id
                                           . Value
                                           )
                                   ) <*> evaluate x
evaluate (Value x)          = pure $ pure x
evaluate (Variable x)       = pure . fromMaybe (bindError x)
                                   . lookup x
evaluate (Bind x y z)       = evaluate z . assoc x y
evaluate (Identity x)       = evaluate x
evaluate (Add x y)          = pure (liftA2 (+)) <*> evaluate x
                                                <*> evaluate y
evaluate (Subtract x y)     = pure (liftA2 (-)) <*> evaluate x
                                                <*> evaluate y
evaluate (Negate x)         = pure (liftA negate) <*> evaluate x
evaluate (Multiply x y)     = pure (liftA2 (*)) <*> evaluate x
                                                <*> evaluate y
evaluate (Divide x y)       = pure (liftA2 (/)) <*> evaluate x
                                                <*> evaluate y
evaluate (Exponentiate x y) = pure (liftA2 (**)) <*> evaluate x
                                                 <*> evaluate y
evaluate (Root x y)         = pure (liftA2 ((. (1 /)) . (**))) <*> evaluate x
                                                               <*> evaluate y

evaluate_ :: Floating a => Expression a -> [a]
evaluate_ = flip evaluate []
-}
