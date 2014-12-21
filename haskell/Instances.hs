-- | Useful instances.
module Instances () where

import Control.Applicative ((<*>), Applicative)
import Control.Monad ((>>=), Monad)
import Data.Functor ((<$>), Functor)

import Data (Tree (..))

instance Functor Tree where
         f `fmap` TElement x = TElement (f x)
         f `fmap` TPair x y = TPair (f <$> x) (f <$> y)

instance Applicative Tree where
         pure = TElement
         TElement f <*> x = f <$> x
         TPair f g <*> x = TPair (f <*> x) (g <*> x)

instance Monad Tree where
         return = pure
         TElement x >>= f = f x
         TPair x y >>= f = TPair (x >>= f) (y >>= f)
