-- | Useful instances.
module Help () where

import Data.IORef (IORef)
import Prelude (IO, Show, const, show)
import Text.Show.Functions ()

instance Show (IO a) where
         show = const "<effect>"

instance Show a => Show (IORef a) where
         show = const "<reference>"
