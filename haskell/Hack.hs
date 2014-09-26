module Hack () where

import Data.IORef (IORef, readIORef)
import Prelude ((.), Show, show)
import System.IO.Unsafe (unsafePerformIO)
import Text.Show.Functions ()

instance Show a => Show (IORef a) where
         show = show . unsafePerformIO . readIORef
