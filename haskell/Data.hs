-- | Common data types.
module Data where

import Data.Array (Array)
import Data.IORef (IORef)
import Data.Map (Map)
import Data.Text (Text)
import Prelude (Bool, Char, Int, Integer, IO, Show, String)
import System.IO (FilePath)

import Instances ()

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
                | EData Expression
                | ECode Expression
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
data Failure = FFuck -- There will surely be a million.
             deriving Show

-- | Things that annoy the programmer.
data Warning = WIntent IntentWarning
             | WStyle StyleWarning
             deriving Show

-- | Bad ideas.
data IntentWarning = EmptySomething -- Function, binding, ...
                   | DuplicateImport
                   | DuplicateExport
                   | RepeatedAlias
                   | RepeatedAliases
                   | DeadCode
                   | SingleUseLocal
                   | Deprecated
                   | StrangeType
                   | StupidIdea
                   deriving Show

-- In addition to provoking warnings, the compiler should suggest trivial fixes.
-- These are just some ideas for common style problems.
-- | Bad ways to express ideas.
data StyleWarning = SpaceAfterLeftParenthesis
                  | SpaceBeforeRightParenthesis
                  | SpaceAfterLeftBracket
                  | SpaceBeforeRightBracket
                  | LinebreakAfterOrBeforeWhatever
                  | LeadingSpacesInComment -- ?
                  | TrailingSpaces
                  | TwoSpaces
                  | ThreeLinebreaks
                  | NoParagraphLinebreaks
                  | BrokenParagraph
                  | IncorrectIndentation
                  | MixedIndentation
                  | TooManyRows
                  | TooManyColumns
                  | EmptyComment
                  | DubiousName -- Such as uRgH?.
                  | RidiculousName -- Such as f2(x&-'.
                  | KindOfBadName -- Such as convention_breaking.
                  | NoAlphabeticalOrder -- Sounds dumb.
                  | NoOrderByDependence
                  | NoModulesInFile
                  | MultipleModulesInFile
                  | ReservedName -- For a brighter future!
                  | ExtraParentheses
                  | ExtraBrackets
                  | NoDocumentation
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
