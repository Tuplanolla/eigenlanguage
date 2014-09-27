module Interpreter (loop) where

import Common
import Evaluator hiding (putLn)
import Formatter
import Lexer
import Parser
import Tester

import Control.Exception
import Data.Functor
import Data.List (intercalate)
import Data.Map hiding (map)
import System.IO

loop :: IO ()
loop = do putStrLn "Eigenlanguage Interpreter 0.0.0/2014-09-27 (approximately)"
          putStrLn $ "Write code using " ++
           (intercalate ", " . map fst . toList $ systemEnv)
           ++ " or some of the special forms and hit done (Enter to flush and Ctrl D to stop) or cancel (Ctrl C anywhere)."
          loopWith (0, []) -- User experience goes here.

loopWith :: (Int, [Token]) -> IO ()
loopWith (d, t) = do if d > 0 then
                        putStr "#... " else
                        putStr "#|E> "
                     flush
                     e <- isEOF
                     if e then
                        putStrLn "#q" else
                        do ts <- eigenlex <$> getLine
                           let ds = d + depth ts
                           if ds > 0 then -- It's called a bird's nest.
                              loopWith (ds, t ++ ts) else
                              (do let e = eigenevaluate . eigenparse $ t ++ ts
                                  case e of
                                       ENothing -> return ()
                                       EEffect x -> do _ <- x
                                                       return ()
                                       _ -> putStrLn . eigenformat $ e
                                  loopWith (0, [])) `catch` -- It's good.
                                   \ e -> do putStrLn . show $ (e :: SomeException)
                                             loopWith (0, [])

depth :: [Token] -> Int
depth = sum . (change <$>)

change :: Token -> Int
change TOpen = 1
change TClose = -1
change _ = 0

putLn :: IO ()
putLn = putStrLn ""

flush :: IO ()
flush = hFlush stdout
