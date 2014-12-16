-- | Instances for IO.
module IO () where

import Data.IORef (IORef)
import Prelude (IO, Show, show)
import Text.Show.Functions ()

instance Show (IO a) where
         show _ = "<effect>"

instance Show (IORef a) where
         show _ = "<reference>"
