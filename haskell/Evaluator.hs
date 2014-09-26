module Evaluator where -- This is bad.

import Control.Applicative
import Control.Monad hiding (sequence)
import Data.Functor
import Data.Map (Map, fromList, lookup, mapWithKey, union)
import Data.Traversable
import Prelude hiding (lookup, sequence)

import Common
import Parser

eigenevaluate :: Expression -> IO Expression
eigenevaluate x = do e <- systemEnv
                     evaluate e x

evaluate :: Environment -> Expression -> IO Expression
evaluate b (EProcedure f) = return $ EProcedure (\ x -> evaluate b =<< f x)
evaluate b (EPair (ESymbol "`") x) = unevaluate b x
evaluate b (EPair (ESymbol ",") x) = error "already unpacked" {- This should
never happen (assuming the parser works correctly). -}
evaluate b (EPair (EPair (ESymbol "->") (ESymbol x)) y)
 = return $ EProcedure $ \ z -> evaluate b (EBind (fromList [(x, z)]) y)
evaluate b (EPair (EPair (ESymbol "->") (EPair (ESymbol x) q)) y)
 = return $ EProcedure $ \ z -> evaluate b (EPair (EPair (ESymbol "->") q)
                                                  (EBind (fromList [(x, z)]) y))
evaluate b (EPair (EPair (ESymbol "=") xs) y)
 = evaluate b (EBind (fromList (listidate xs)) y)
evaluate b (EPair f x) = do p <- evaluate b f
                            q <- evaluate b x
                            apply p q
evaluate b (EBind e x) = evaluate (union e b) x
evaluate b (ESymbol k) = evaluate b (fetch k b (lookup k b)) -- This is eager.
evaluate b x = return x

apply :: Expression -> Expression -> IO Expression
apply (EProcedure f) x = f x
apply f _ = error ("not a function: " ++ show f)

unevaluate :: Environment -> Expression -> IO Expression
unevaluate b (EPair (ESymbol ",") x) = evaluate b x
unevaluate b (EPair f x) = EPair <$> unevaluate b f <*> unevaluate b x
unevaluate b x = return x

listidate :: Expression -> [(Name, Expression)]
listidate (EPair (EPair x (ESymbol z)) y) = (z, y) : listidate x
listidate (EPair (ESymbol x) y) = [(x, y)]

fetch k b (Just v) = v
fetch k b _ = error ("not a name: " ++ k)

assoc :: Eq k => k -> v -> [(k, v)] -> [(k, v)]
assoc k v xs = (k, v) : filter ((k /=) . fst) xs

systemEnv :: IO Environment
systemEnv = sequence $ fromList
 [("-", liftInteger2 (-)),
  ("*", liftInteger2 (*)),
  ("+", liftInteger2 (+)),
  ("true", return $ ELogical True),
  ("false", return $ ELogical False),
  ("always", liftAlways),
  ("if", liftIf),
  ("<", liftIntegerPredicate (<)),
  ("evaluate", liftEvaluate),
  ("print-character", liftPrintChar putChar)]

liftPrintChar :: (Char -> IO ()) -> IO Expression
liftPrintChar f = let run = (getCharacter <$>) . evaluate (fromList empty) in
                      return $ EProcedure (\ x -> (f =<< run x) >> return ENothing)

ite :: Bool -> a -> a -> a
ite x y z = if x then y else z

liftIf :: IO Expression
liftIf = let run = (getLogical <$>) . evaluate (fromList empty) in
             return $ EProcedure (\ x -> return $ EProcedure (\ y -> return $ EProcedure (\ z -> ite <$> run x <*> return y <*> return z)))

liftAlways :: IO Expression
liftAlways = return $ EProcedure (\ x -> return $ EProcedure (\ y -> return x))

liftEvaluate :: IO Expression
liftEvaluate = return $ EProcedure eigenevaluate

-- The rest is automatically generated.

getInteger :: Expression -> Integer
getInteger (EInteger x) = x
getInteger _ = error "not an integer"

getLogical :: Expression -> Bool
getLogical (ELogical x) = x
getLogical _ = error "not a logical"

getCharacter :: Expression -> Char
getCharacter (ECharacter x) = x
getCharacter _ = error "not a character"

liftInteger :: (Integer -> Integer) -> IO Expression
liftInteger f = let run = (getInteger <$>) . evaluate (fromList empty) in
                    return $ EProcedure (\ x -> EInteger <$> (f <$> run x))

liftInteger2 :: (Integer -> Integer -> Integer) -> IO Expression
liftInteger2 f = let run = (getInteger <$>) . evaluate (fromList empty) in
                     return $ EProcedure (\ x -> return $ EProcedure (\ y -> EInteger <$> (f <$> run x <*> run y)))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> IO Expression
liftInteger3 f = let run = (getInteger <$>) . evaluate (fromList empty) in
                     return $ EProcedure (\ x -> return $ EProcedure (\ y -> return $ EProcedure (\ z -> EInteger <$> (f <$> run x <*> run y <*> run z))))


liftIntegerPredicate :: (Integer -> Integer -> Bool) -> IO Expression
liftIntegerPredicate f = let run = (getInteger <$>) . evaluate (fromList empty) in
                     return $ EProcedure (\ x -> return $ EProcedure (\ y -> ELogical <$> (f <$> run x <*> run y)))
