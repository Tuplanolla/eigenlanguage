module Tester (Test (..), tests) where

import Common (Code, Name)

tests :: [Test]
tests = [Test {name = "Nothing",
               difficulty = Easy,
               code = "\
\()\n\
\"},
         Test {name = "Nothing",
               difficulty = Hard,
               code = "\
\\n\
\"},
         Test {name = "Value",
               difficulty = Easy,
               code = "\
\13\n\
\"},
         Test {name = "Value",
               difficulty = Hard,
               code = "\
\always (always 13) \"two\" '3'\n\
\"},
         Test {name = "Arithmetic",
               difficulty = Easy,
               code = "\
\- (* (+ 2 3) \n\
\     (+ 4 5))\n\
\  32         \n\
\"},
         Test {name = "Arithmetic",
               difficulty = Hard,
               code = "\
\( ((-) ((((*) ((+) (2) (3)))\n\
\           (((+) 4) 5)))    \n\
\    (32)) )                 \n\
\"},
         Test {name = "Binding",
               difficulty = Easy,
               code = "\
\- (+ 2 (= (x 3)    \n\
\          (* x 4)))\n\
\  1                \n\
\"},
         Test {name = "Binding",
               difficulty = Hard,
               code = "\
\- (+ 2 (= (x 3     \n\
\           y 4)    \n\
\          (* x y)))\n\
\  1                \n\
\"},
         Test {name = "Scope",
               difficulty = Easy,
               code = "\
\= (x 4)             \n\
\  (- (+ 2           \n\
\        (= (y 3)    \n\
\           (* y x)))\n\
\     1)             \n\
\"},
         Test {name = "Scope",
               difficulty = Hard,
               code = "\
\= (x 2)               \n\
\  (- (+ x             \n\
\        (= (x (+ y 3) \n\
\            y 4       \n\
\            z (- x 5))\n\
\           (* x z)))  \n\
\     3)               \n\
\"},
         Test {name = "Function",
               difficulty = Easy,
               code = "\
\(-> x (+ 2 x)) 11\n\
\"},
         Test {name = "Function",
               difficulty = Hard,
               code = "\
\-> (x y) (+ x y) (-> x 2 3) 11\n\
\"},
         Test {name = "Recursion",
               difficulty = Easy,
               code = "\
\= (f (-> n                       \n\
\         (if (< n 2)             \n\
\             n                   \n\
\             (* n (f (- n 1))))))\n\
\  (- (f 4) 11)                   \n\
\"},
         Test {name = "Recursion",
               difficulty = Hard,
               code = "\
\= (f (-> n                     \n\
\         (if (< n 2)           \n\
\             n                 \n\
\             (+ (f (- n 1))    \n\
\                (f (- n 2))))))\n\
\  (f 7)                        \n\
\"},
         Test {name = "Data",
               difficulty = Easy,
               code = "\
\+ (evaluate (` (* 2 3))) 7\n\
\"},
         Test {name = "Data",
               difficulty = Hard,
               code = "\
\+ (evaluate `(* 2 ,(always 3 4))) 7\n\
\"},
         Test {name = "Laziness",
               difficulty = Easy,
               code = "\
\if (< 2 3)            \n\
\   13                 \n\
\   (= (f (-> x (f x)))\n\
\      (f f))          \n\
\"},
         Test {name = "Laziness",
               difficulty = Hard,
               code = "\
\always 13 (= (f (-> x (f x)))\n\
\             (f f))          \n\
\"},
         Test {name = "Tail",
               difficulty = Easy,
               code = "\
\= (f (-> n                 \n\
\         (if (< n 1)       \n\
\             13            \n\
\             (f (- n 1)))))\n\
\  (f 1024)                 \n\
\"},
         Test {name = "Tail",
               difficulty = Hard,
               code = "\
\= (f (-> n                 \n\
\         (if (< n 1)       \n\
\             13            \n\
\             (f (- n 1)))))\n\
\  (f 1048576)              \n\
\"},
         Test {name = "Output",
               difficulty = Easy,
               code = "\
\print-character '1' io\n\
\"},
         Test {name = "Output",
               difficulty = Hard,
               code = "\
\= (io' (print-character '1' io))\n\
\  (print-character '3' io')     \n\
\"},
         Test {name = "Comments",
               difficulty = Easy,
               code = "\
\- (* (+ 2 #comment 3)  \n\
\     (+ 4 5)) # comment\n\
\  32                   \n\
\"},
         Test {name = "Comments",
               difficulty = Hard,
               code = "\
\- (* (+ 2 #(nested #comments # with       \n\
\            #`more `#than one #(#line)) 3)\n\
\     (#! + 4 5 #!))                       \n\
\  32                                      \n\
\"}]

data Test = Test {name :: Name,
                  difficulty :: Difficulty,
                  code :: Code}

data Difficulty = Easy | Hard
