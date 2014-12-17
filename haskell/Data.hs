-- | Common data types.
module Data where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Data.Text.Lazy (Text)
-- import Data.Tree (Tree)
import Prelude (Bool, Char, Eq, Int, Integer, IO, Show, String)
import System.IO (FilePath)

import IO ()

-- There are two syntax trees: parse level and evaluation level.
-- Perhaps later one even needs a compilation level tree.
-- This structure underlies all of them.

data Tree a = TElement a
            | TPair (Tree a) (Tree a)
            deriving (Eq, Show)

data Parse = PSymbol Symbol
           | PSingleton
           | PTag Tag
           deriving (Eq, Show)

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
                | ESyntacticComment Expression
                | EBlockComment Code
                | ELineComment Code
                | ETag Tag Expression
                | ENothing
                deriving Show

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
         | TFilePath FilePath
         | TLineNumber Nat
         | TColumnNumber Nat
         | TColor Color
         deriving (Eq, Show)

{- |
Recursive directions with a symmetric diagram.

@
L - R
@
-}
data Direction = DLeft
               | DRight
               deriving (Eq, Show)

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
           deriving (Eq, Show)

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
           deriving (Eq, Show)

-- | Location of an error or a warning.
data Location a = LLocation FilePath Nat Nat a
                deriving (Eq, Show)

data Problem = PError Error
             | PWarning Warning
             deriving (Eq, Show)

-- | Things that ruin everything.
data Error = EParse ParseError
           | EEvaluation EvaluationError
           deriving (Eq, Show)

-- | Problems with grammar.
data ParseError = PFFuckedUp
                deriving (Eq, Show)

-- | Uncaught runtime exceptions.
data EvaluationError = EFFuckedUp -- There will surely be a million.
                     deriving (Eq, Show)

-- | Things that annoy the programmer.
data Warning = WEvaluation EvaluationWarning
             | WParse ParseWarning -- and row, column
             deriving (Eq, Show)

-- | Bad ideas.
data EvaluationWarning = EWEmptySomething -- Function, binding, ...
                       | EWDuplicateImport
                       | EWDuplicateExport
                       | EWRepeatedAlias
                       | EWRepeatedAliases
                       | EWDeadCode
                       | EWSingleUseLocal
                       | EWDeprecated
                       | EWStrangeType
                       | EWStupidIdea
                       deriving (Eq, Show)

-- In addition to provoking warnings, the compiler should suggest trivial fixes.
-- These are just some ideas for common style problems.
-- | Bad ways to express ideas.
data ParseWarning = PWSpaceAfterLeftParenthesis
                  | PWSpaceBeforeRightParenthesis
                  | PWSpaceAfterLeftBracket
                  | PWSpaceBeforeRightBracket
                  | PWLinebreakAfterOrBeforeWhatever
                  | PWLeadingSpacesInComment -- ?
                  | PWTrailingSpaces
                  | PWTwoSpaces
                  | PWThreeLinebreaks
                  | PWNoParagraphLinebreaks
                  | PWBrokenParagraph
                  | PWIncorrectIndentation
                  | PWMixedIndentation
                  | PWTooManyRows
                  | PWTooManyColumns
                  | PWEmptyComment
                  | PWDubiousName -- Such as uRgH?.
                  | PWRidiculousName -- Such as f2(x&-'.
                  | PWKindOfBadName -- Such as convention_breaking.
                  | PWNoAlphabeticalOrder -- Sounds dumb.
                  | PWNoOrderByDependence
                  | PWNoModulesInFile
                  | PWMultipleModulesInFile
                  | PWReservedName -- For a brighter future!
                  | PWExtraParentheses
                  | PWExtraBrackets
                  | PWNoDocumentation
                  deriving (Eq, Show)

-- | Essentially @[(Symbol, Expression)]@ without ordering.
type Environment = Map Symbol Expression

-- | Nearly unrestricted, for source code.
type Code = Text

-- | Somewhat restricted, for symbol names.
type Symbol = Text

-- | Very restricted, for module names.
type Name = Text

-- | Zero or positive and bounded.
type Nat = Int

-- | Zero or positive.
type Natural = Integer
