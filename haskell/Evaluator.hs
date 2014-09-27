module Evaluator where -- This is bad.

import Control.Applicative
import Control.Monad
import Data.Functor
import Data.IORef
import Data.Map (Map, fromList, lookup, mapWithKey, union)
import Prelude hiding (lookup)

import Common
import Parser

eigenevaluate :: Expression -> Expression
eigenevaluate = evaluate systemEnv

evaluate :: Environment -> Expression -> Expression
evaluate b (EFunction f) = EFunction (evaluate b . f)
evaluate b (EPair (ESymbol "`") x) = unevaluate b x
evaluate b (EPair (EPair (ESymbol "->")
                         (ESymbol x)) y) = EFunction $ \ z -> evaluate b (EBind (fromList [(x, z)]) y)
evaluate b (EPair (EPair (ESymbol "->")
                         (EPair (ESymbol x) q)) y) = EFunction $ \ z -> evaluate b (EPair (EPair (ESymbol "->") q)
                                                                                          (EBind (fromList [(x, z)]) y))
evaluate b (EPair (EPair (ESymbol "=") xs) y) = evaluate b (EBind (fromList (listidate xs)) y)
evaluate b (EPair f x) = apply (evaluate b f) (evaluate b x)
evaluate b (EBind e x) = let bind y z = evaluate b (EBind e z) in
                             evaluate ((bind `mapWithKey` e) `union` b) x
evaluate b (ESymbol k) = fetch k b (lookup k b)
evaluate b (EEffect x) = EEffect (evaluate b <$> x)
evaluate b x = x

unevaluate :: Environment -> Expression -> Expression
unevaluate b (EPair (ESymbol ",") x) = evaluate b x
unevaluate b (EPair f x) = EPair (unevaluate b f) (unevaluate b x)
unevaluate b x = x

listidate :: Expression -> [(Name, Expression)]
listidate (EPair (EPair x (ESymbol z)) y) = (z, y) : listidate x
listidate (EPair (ESymbol x) y) = [(x, y)]

apply :: Expression -> Expression -> Expression
apply (EFunction f) x = f x
apply f _ = error ("not a function: " ++ show f)

fetch k b (Just v) = v
fetch k b _ = error ("not a name: " ++ k)

systemEnv :: Environment
systemEnv = fromList [("-", liftInteger2 (-)),
                      ("*", liftInteger2 (*)),
                      ("+", liftInteger2 (+)),
                      ("true", ELogical True),
                      ("false", ELogical False),
                      ("always", liftAlways),
                      ("if", liftIf),
                      ("<", liftIntegerPredicate (<)),
                      ("evaluate", liftEvaluate),
                      ("io", EEffect $ EUnique <$> newIORef True),
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
liftPC f = let run = getCharacter . evaluate (fromList empty)
               run' = (getUnique <$>) . getEffect . evaluate (fromList empty) in
               EFunction (\ x -> EFunction (\ y -> EEffect $ EUnique <$> (touch (f $ run x) =<< (run' y))))

liftIf :: Expression
liftIf = let run = getLogical . evaluate (fromList empty) in
             EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> if run x then y else z)))

liftAlways :: Expression
liftAlways = EFunction (\ x -> EFunction (\ y -> x))

liftEvaluate :: Expression
liftEvaluate = EFunction eigenevaluate

-- The rest is automatically generated.

getEffect :: Expression -> IO Expression
getEffect (EEffect x) = x
getEffect x = error ("not an effect: " ++ show x)

getUnique :: Expression -> IORef Bool
getUnique (EUnique x) = x
getUnique x = error ("not a uniqueness type: " ++ show x)

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
liftInteger f = let run = getInteger . evaluate (fromList empty) in
                    EFunction (\ x -> EInteger (f (run x)))

liftInteger2 :: (Integer -> Integer -> Integer) -> Expression
liftInteger2 f = let run = getInteger . evaluate (fromList empty) in
                     EFunction (\ x -> EFunction (\ y -> EInteger (f (run x) (run y))))

liftInteger3 :: (Integer -> Integer -> Integer -> Integer) -> Expression
liftInteger3 f = let run = getInteger . evaluate (fromList empty) in
                     EFunction (\ x -> EFunction (\ y -> EFunction (\ z -> EInteger (f (run x) (run y) (run z)))))

liftIntegerPredicate :: (Integer -> Integer -> Bool) -> Expression
liftIntegerPredicate f = let run = getInteger . evaluate (fromList empty) in
                             EFunction (\ x -> EFunction (\ y -> ELogical (f (run x) (run y))))

putLn :: IO ()
putLn = putStrLn ""
