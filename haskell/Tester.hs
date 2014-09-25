module Tester where

tests = let interleave (x : xs) ys = x : interleave ys xs
            interleave _ ys = ys in
            interleave testsEasy testsHard

testsEasy :: [String]
testsEasy = [testNothingEasy,
             testValueEasy,
             testArithmeticEasy,
             testBindingEasy,
             testScopeEasy,
             testFunctionEasy,
             testRecursionEasy,
             testDataEasy,
             testLazinessEasy,
             testTailEasy,
             testCommentsEasy]

testsHard :: [String]
testsHard = [testNothingHard,
             testValueHard,
             testArithmeticHard,
             testBindingHard,
             testScopeHard,
             testFunctionHard,
             testRecursionHard,
             testDataHard,
             testLazinessHard,
             testTailHard,
             testCommentsHard]

testNothingEasy :: String
testNothingEasy = "\
\()\n\
\"

testNothingHard :: String
testNothingHard = "\
\\n\
\"

testValueEasy :: String
testValueEasy = "\
\13\n\
\"

testValueHard :: String
testValueHard = "\
\always (always 13) \"two\" '3'\n\
\"

testArithmeticEasy :: String
testArithmeticEasy = "\
\- (* (+ 2 3) \n\
\     (+ 4 5))\n\
\  32         \n\
\"

testArithmeticHard :: String
testArithmeticHard = "\
\( ((-) ((((*) ((+) (2) (3)))\n\
\           (((+) 4) 5)))    \n\
\    (32)) )                 \n\
\"

testBindingEasy :: String
testBindingEasy = "\
\- (+ 2 (= (x 3)    \n\
\          (* x 4)))\n\
\  1                \n\
\"

testBindingHard :: String
testBindingHard = "\
\- (+ 2 (= (x 3     \n\
\           y 4)    \n\
\          (* x y)))\n\
\  1                \n\
\"

testScopeEasy :: String
testScopeEasy = "\
\= (x 4)             \n\
\  (- (+ 2           \n\
\        (= (y 3)    \n\
\           (* y x)))\n\
\     1)             \n\
\"

testScopeHard :: String
testScopeHard = "\
\= (x 2)               \n\
\  (- (+ x             \n\
\        (= (x (+ y 3) \n\
\            y 4       \n\
\            z (- x 5))\n\
\           (* x z)))  \n\
\     3)               \n\
\"

testFunctionEasy :: String
testFunctionEasy = "\
\(-> x (+ 2 x)) 11\n\
\"

testFunctionHard :: String
testFunctionHard = "\
\-> (x y) (+ x y) (-> x 2 3) 11\n\
\"

testRecursionEasy :: String
testRecursionEasy = "\
\= (f (-> n                       \n\
\         (if (< n 2)             \n\
\             n                   \n\
\             (* n (f (- n 1))))))\n\
\  (- (f 4) 11)                   \n\
\"

testRecursionHard :: String
testRecursionHard = "\
\= (f (-> n                     \n\
\         (if (< n 2)           \n\
\             n                 \n\
\             (+ (f (- n 1))    \n\
\                (f (- n 2))))))\n\
\  (f 7)                        \n\
\"

testDataEasy :: String
testDataEasy = "\
\+ (evaluate (` (* 2 3))) 7\n\
\"

testDataHard :: String
testDataHard = "\
\+ (evaluate `(* 2 ,(always 3 4))) 7\n\
\"

testLazinessEasy :: String
testLazinessEasy = "\
\if (< 2 3)            \n\
\   13                 \n\
\   (= (f (-> x (f x)))\n\
\      (f f))          \n\
\"

testLazinessHard :: String
testLazinessHard = "\
\always 13 (= (f (-> x (f x)))\n\
\             (f f))          \n\
\"

testTailEasy :: String
testTailEasy = "\
\= (f (-> n                 \n\
\         (if (< n 1)       \n\
\             13            \n\
\             (f (- n 1)))))\n\
\  (f 1024)                 \n\
\"

testTailHard :: String
testTailHard = "\
\= (f (-> n                 \n\
\         (if (< n 1)       \n\
\             13            \n\
\             (f (- n 1)))))\n\
\  (f 1048576)              \n\
\"

testCommentsEasy :: String
testCommentsEasy = "\
\- (* (+ 2 #comment 3)  \n\
\     (+ 4 5)) # comment\n\
\  32                   \n\
\"

testCommentsHard :: String
testCommentsHard = "\
\- (* (+ 2 #(nested #comments # with       \n\
\            #`more `#than one #(#line)) 3)\n\
\     (#! + 4 5 #!))                       \n\
\  32                                      \n\
\"
