module Hack () where

import Data.IORef (IORef, readIORef)
import Prelude ((.), IO, Show, const, show)
import System.IO.Unsafe (unsafePerformIO)
import Text.Show.Functions ()

instance Show (IO a) where
         show = const "IO"

instance Show a => Show (IORef a) where
         show = show . unsafePerformIO . readIORef
