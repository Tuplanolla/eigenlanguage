module Example where

examples :: [String]
examples = let merge (x : xs) ys = x : merge ys xs
               merge _ ys = ys in
               merge examplesEasy examplesHard

examplesEasy :: [String]
examplesEasy = [exampleValueEasy,
                exampleArithmeticEasy,
                exampleBindingEasy,
                exampleScopeEasy,
                exampleFunctionEasy,
                exampleRecursionEasy,
                exampleDataEasy,
                exampleLazinessEasy]

examplesHard :: [String]
examplesHard = [exampleValueHard,
                exampleArithmeticHard,
                exampleBindingHard,
                exampleScopeHard,
                exampleFunctionHard,
                exampleRecursionHard,
                exampleDataHard,
                exampleLazinessHard]

exampleValueEasy :: String
exampleValueEasy = " \
\ 13 \
\ "

exampleValueHard :: String
exampleValueHard = " \
\ always (always 13) \"two\" '3' \
\ "

exampleArithmeticEasy :: String
exampleArithmeticEasy = " \
\ - (* (+ 2 3)  \
\      (+ 4 5)) \
\   32          \
\ "

exampleArithmeticHard :: String
exampleArithmeticHard = " \
\ ( ((-) ((((*) ((+) (2) (3))) \
\            (((+) 4) 5)))     \
\     (32)) )                  \
\ "

exampleBindingEasy :: String
exampleBindingEasy = " \
\ - (+ 2 (= x 3       \
\           (* x 4))) \
\   1                 \
\ "

exampleBindingHard :: String
exampleBindingHard = " \
\ - (+ 2 (= x 3       \
\           y 4       \
\           (* x y))) \
\   1                 \
\ "

exampleScopeEasy :: String
exampleScopeEasy = " \
\ = x 4                \
\   (- (+ 2            \
\         (= y 3       \
\            (* y x))) \
\      1)              \
\ "

exampleScopeHard :: String
exampleScopeHard = " \
\ = x 2                \
\   (- (+ x            \
\         (= x (- y 1) \
\            y 4       \
\            (* x y))) \
\      1)              \
\ "

exampleFunctionEasy :: String
exampleFunctionEasy = " \
\ (-> x (+ 2 x)) 11 \
\ "

exampleFunctionHard :: String
exampleFunctionHard = " \
\ (-> x y (+ x y)) ((-> x 2) 3) 11 \
\ "

exampleRecursionEasy :: String
exampleRecursionEasy = " \
\ = f (-> n                       \
\         (if (< n 2)             \
\             n                   \
\             (* n (f (- n 1))))) \
\   (- (f 4) 11)                  \
\ "

exampleRecursionHard :: String
exampleRecursionHard = " \
\ = f (-> n                     \
\         (if (< n 2)           \
\             n                 \
\             (+ (f (- n 1))    \
\                (f (- n 2))))) \
\   (f 7)                       \
\ "

exampleDataEasy :: String
exampleDataEasy = " \
\ + (evaluate '(* 2 3)) 7 \
\ "

exampleDataHard :: String
exampleDataHard = " \
\ + (evaluate '(* 2 ,(always 3 4))) 7 \
\ "

exampleLazinessEasy :: String
exampleLazinessEasy = " \
\ if (< 2 3)                  \
\    13                       \
\    (= f (-> x (f x)) (f f)) \
\ "

exampleLazinessHard :: String
exampleLazinessHard = " \
\ always 13 (= f (-> x (f x)) (f f)) \
\ "
