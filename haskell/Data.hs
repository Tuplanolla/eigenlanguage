-- | Common data types.
module Data where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Data.Text.Lazy (Text)
import Prelude (Bool, Char, Int, Integer, IO, Show, String)
import System.IO (FilePath)

import Instances ()

{- |
Syntax in pieces.
-}
data Lexeme = LLeftOpen
            | LLeftClose
            | LRightOpen
            | LRightClose
            | LData
            | LCode
            | LComment
            | LLineComment Code
            | LBlockComment Code
            | LSymbol Code
            | LSpace Nat
            | LLineBreak Nat
            | LInteger Nat
            | LCharacter Char
            | LString String
            deriving Show

{- |
Syntax with an asymmetric diagram.

@
          S

          A
          |
  P ----- S ----- L
 / \     / \     / \
D - C   E - U   I - C

          E
         / \
      R A - L A
         \ /
          M
          |
          Q

          T
@
-}
data Expression = ESymbol Symbol
                | EPair Expression Expression
                -- ^ Function application and group construction.
                | ESingleton
                | ESomeData Expression
                | ESomeCode Expression
                | EMoreData Expression
                | EMoreCode Expression
                | EEquality Environment Expression
                -- ^ Binding and aliasing.
                | ERightArrow (Expression -> Expression)
                -- ^ Function definition and exporting.
                | ELeftArrow
                -- ^ Dynamic importing.
                | EModule Name Expression
                -- Needs something.
                | EQualification Name Symbol
                -- Something something.
                | EEffect (IO Expression)
                | EUnique (IORef Bool)
                | EArray (Array Int Expression) -- listArray (1, 0) []
                | ELogical Bool
                | EInteger Integer
                | ECharacter Char
                | ETag Tag Expression
                deriving Show

{- |
Syntax augmentations with an asymmetric diagram.

@
D   C   A   O   R   I

S   C - B   C - L   C

F   P - L   N - C   N

          C
@
-}
data Tag = TDirection Direction
         -- ^ Whether a pair is built from parentheses or brackets.
         | TContinuous Bool
         -- ^ Whether a list of characters is a string or an actual list.
         | TArity Natural
         -- ^ How deeply a function definition is nested.
         | TOrdering [Symbol]
         -- ^ The order of symbols in a binding.
         | TRadix Natural
         -- ^ The base of a numeric literal.
         | TIndentation Depth
         -- ^ A heuristic for the way a line is indented.
         | TSyntacticComment Code
         | TBlockComment Comment
         | TLineComment Comment
         | TFilePath FilePath
         | TLineNumber Nat
         | TColumnNumber Nat
         | TColor Color
         deriving Show

{- |
Recursive directions with a symmetric diagram.

@
L - R
@
-}
data Direction = DLeft
               | DRight
               deriving Show

{- |
Depth with a symmetric diagram.

@
F   F
 \ /
  M
@
-}
data Depth = Fixed Nat
           -- ^ Spaces.
           | Flexible Nat
           -- ^ Tabs.
           | Mixed
           deriving Show

{- |
Colors with a symmetric diagram.

@
  B - M
 / \ / \
C - N - R
 \ / \ /
  G - Y
@
-}
data Color = CNeutral
           -- ^ Analogous to black or white.
           | CRed
           | CGreen
           | CBlue
           | CCyan
           -- ^ Antired.
           | CMagenta
           -- ^ Antigreen.
           | CYellow
           -- ^ Antiblue.
           deriving Show

-- | Things that ruin everything.
data Failure = FParse ParseFailure
             | FEvaluation EvaluationFailure
             deriving Show

-- | Problems with grammar.
data ParseFailure = PFFuckedUp
                  deriving Show

-- | Uncaught runtime exceptions.
data EvaluationFailure = EFFuckedUp -- There will surely be a million.
                       deriving Show

-- | Things that annoy the programmer.
data Warning = WIntent IntentWarning
             | WStyle StyleWarning -- and row, column
             deriving Show

-- | Bad ideas.
data IntentWarning = IWEmptySomething -- Function, binding, ...
                   | IWDuplicateImport
                   | IWDuplicateExport
                   | IWRepeatedAlias
                   | IWRepeatedAliases
                   | IWDeadCode
                   | IWSingleUseLocal
                   | IWDeprecated
                   | IWStrangeType
                   | IWStupidIdea
                   deriving Show

-- In addition to provoking warnings, the compiler should suggest trivial fixes.
-- These are just some ideas for common style problems.
-- | Bad ways to express ideas.
data StyleWarning = SWSpaceAfterLeftParenthesis
                  | SWSpaceBeforeRightParenthesis
                  | SWSpaceAfterLeftBracket
                  | SWSpaceBeforeRightBracket
                  | SWLinebreakAfterOrBeforeWhatever
                  | SWLeadingSpacesInComment -- ?
                  | SWTrailingSpaces
                  | SWTwoSpaces
                  | SWThreeLinebreaks
                  | SWNoParagraphLinebreaks
                  | SWBrokenParagraph
                  | SWIncorrectIndentation
                  | SWMixedIndentation
                  | SWTooManyRows
                  | SWTooManyColumns
                  | SWEmptyComment
                  | SWDubiousName -- Such as uRgH?.
                  | SWRidiculousName -- Such as f2(x&-'.
                  | SWKindOfBadName -- Such as convention_breaking.
                  | SWNoAlphabeticalOrder -- Sounds dumb.
                  | SWNoOrderByDependence
                  | SWNoModulesInFile
                  | SWMultipleModulesInFile
                  | SWReservedName -- For a brighter future!
                  | SWExtraParentheses
                  | SWExtraBrackets
                  | SWNoDocumentation
                  deriving Show

-- | Essentially @[(Symbol, Expression)]@ without ordering.
type Environment = Map Symbol Expression

-- | Nearly unrestricted, for comments.
type Comment = Text

-- | Somewhat restricted, for source code.
type Code = Text

-- | Quite restricted, for symbol names.
type Symbol = Text

-- | Very restricted, for module names.
type Name = Text

-- | Zero or positive and bounded.
type Nat = Int

-- | Zero or positive.
type Natural = Integer
