module Interpreter (loop) where

import Common
import Evaluator hiding (putLn)
import Formatter
import Lexer
import Parser
import Tester

import Control.Exception hiding (evaluate)
import Data.Functor
import Data.List (intercalate)
import Data.Map hiding (map)
import System.IO

loop :: IO ()
loop = do putStrLn "Eigenlanguage Interpreter 0.0.0/2014-09-28 (approximately)"
          putStrLn $ "Write code using " ++
           (intercalate ", " . map fst . toList $ systemEnv)
           ++ ", <-, ->, #, #1, #2, ... (Enter to flush and Ctrl D to stop) or cancel (Ctrl C anywhere)."
          loopWith (1, empty)
                   (0, []) -- User experience goes here.

loopWith :: (Int, Environment) -> (Int, [Token]) -> IO ()
loopWith (n, p) (d, t) = do let s = show n
                            if d <= 0 then
                               putStr ("%#" ++ s ++ " ") else
                               putStr ("%." ++ (const '.' <$> s) ++ " ")
                            flush
                            e <- isEOF
                            if e then
                               putStrLn "#quit" else
                               do l <- getLine
                                  case l of -- It's called a bird's nest.
                                       "#quit" -> return ()
                                       _ -> do let ts = eigenlex l
                                                   ds = d + depth ts
                                               if ds > 0 then
                                                  loopWith (n, p)
                                                           (ds, t ++ ts) else
                                                  (do let e = evaluate (union p systemEnv) . eigenparse $ t ++ ts
                                                      case e of
                                                           ENothing -> return ()
                                                           EEffect x -> do putStrLn . eigenformat $ e
                                                                           putStrLn ("%#" ++ s ++ " #perform")
                                                                           _ <- x
                                                                           putLn
                                                           _ -> putStrLn . eigenformat $ e
                                                      loopWith (n + 1, insert "#" e (insert ("#" ++ show n) e p))
                                                               (0, [])) `catch` -- It's good.
                                                       \ e -> do putStrLn . show $ (e :: SomeException)
                                                                 loopWith (n, p)
                                                                          (0, [])
   
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
