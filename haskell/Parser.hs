{-# OPTIONS_GHC -w #-}
module Parser where

import Lexer

-- parser produced by Happy Version 1.19.0

data HappyAbsSyn t5 t6 t7 t8 t9 t10 t11
	= HappyTerminal (Lexeme)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Parse)
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11

action_0 (12) = happyShift action_6
action_0 (13) = happyShift action_7
action_0 (15) = happyShift action_8
action_0 (17) = happyShift action_9
action_0 (18) = happyShift action_10
action_0 (19) = happyShift action_11
action_0 (20) = happyShift action_12
action_0 (21) = happyShift action_13
action_0 (4) = happyGoto action_14
action_0 (5) = happyGoto action_2
action_0 (7) = happyGoto action_3
action_0 (9) = happyGoto action_4
action_0 (10) = happyGoto action_5
action_0 _ = happyFail

action_1 (12) = happyShift action_6
action_1 (13) = happyShift action_7
action_1 (15) = happyShift action_8
action_1 (17) = happyShift action_9
action_1 (18) = happyShift action_10
action_1 (19) = happyShift action_11
action_1 (20) = happyShift action_12
action_1 (21) = happyShift action_13
action_1 (5) = happyGoto action_2
action_1 (7) = happyGoto action_3
action_1 (9) = happyGoto action_4
action_1 (10) = happyGoto action_5
action_1 _ = happyFail

action_2 _ = happyReduce_18

action_3 _ = happyReduce_4

action_4 _ = happyReduce_5

action_5 (12) = happyShift action_6
action_5 (13) = happyShift action_7
action_5 (15) = happyShift action_8
action_5 (17) = happyShift action_9
action_5 (18) = happyShift action_10
action_5 (19) = happyShift action_11
action_5 (20) = happyShift action_12
action_5 (21) = happyShift action_13
action_5 (5) = happyGoto action_24
action_5 (7) = happyGoto action_3
action_5 (9) = happyGoto action_4
action_5 _ = happyReduce_1

action_6 (12) = happyShift action_6
action_6 (13) = happyShift action_7
action_6 (15) = happyShift action_8
action_6 (17) = happyShift action_9
action_6 (18) = happyShift action_10
action_6 (19) = happyShift action_11
action_6 (20) = happyShift action_12
action_6 (21) = happyShift action_13
action_6 (5) = happyGoto action_23
action_6 (7) = happyGoto action_3
action_6 (9) = happyGoto action_4
action_6 _ = happyFail

action_7 (12) = happyShift action_19
action_7 (14) = happyShift action_20
action_7 (15) = happyShift action_21
action_7 (17) = happyShift action_22
action_7 (18) = happyShift action_10
action_7 (19) = happyShift action_11
action_7 (20) = happyShift action_12
action_7 (21) = happyShift action_13
action_7 (6) = happyGoto action_16
action_7 (8) = happyGoto action_17
action_7 (9) = happyGoto action_18
action_7 _ = happyFail

action_8 (12) = happyShift action_6
action_8 (13) = happyShift action_7
action_8 (15) = happyShift action_8
action_8 (17) = happyShift action_9
action_8 (18) = happyShift action_10
action_8 (19) = happyShift action_11
action_8 (20) = happyShift action_12
action_8 (21) = happyShift action_13
action_8 (5) = happyGoto action_2
action_8 (7) = happyGoto action_3
action_8 (9) = happyGoto action_4
action_8 (10) = happyGoto action_15
action_8 _ = happyFail

action_9 _ = happyReduce_6

action_10 _ = happyReduce_14

action_11 _ = happyReduce_15

action_12 _ = happyReduce_16

action_13 _ = happyReduce_17

action_14 (22) = happyAccept
action_14 _ = happyFail

action_15 (12) = happyShift action_6
action_15 (13) = happyShift action_7
action_15 (15) = happyShift action_8
action_15 (16) = happyShift action_29
action_15 (17) = happyShift action_9
action_15 (18) = happyShift action_10
action_15 (19) = happyShift action_11
action_15 (20) = happyShift action_12
action_15 (21) = happyShift action_13
action_15 (5) = happyGoto action_24
action_15 (7) = happyGoto action_3
action_15 (9) = happyGoto action_4
action_15 _ = happyFail

action_16 _ = happyReduce_3

action_17 _ = happyReduce_9

action_18 _ = happyReduce_10

action_19 (12) = happyShift action_19
action_19 (14) = happyShift action_20
action_19 (15) = happyShift action_21
action_19 (17) = happyShift action_22
action_19 (18) = happyShift action_10
action_19 (19) = happyShift action_11
action_19 (20) = happyShift action_12
action_19 (21) = happyShift action_13
action_19 (6) = happyGoto action_28
action_19 (8) = happyGoto action_17
action_19 (9) = happyGoto action_18
action_19 _ = happyFail

action_20 (12) = happyShift action_6
action_20 (13) = happyShift action_7
action_20 (15) = happyShift action_8
action_20 (17) = happyShift action_9
action_20 (18) = happyShift action_10
action_20 (19) = happyShift action_11
action_20 (20) = happyShift action_12
action_20 (21) = happyShift action_13
action_20 (5) = happyGoto action_27
action_20 (7) = happyGoto action_3
action_20 (9) = happyGoto action_4
action_20 _ = happyFail

action_21 (12) = happyShift action_19
action_21 (14) = happyShift action_20
action_21 (15) = happyShift action_21
action_21 (17) = happyShift action_22
action_21 (18) = happyShift action_10
action_21 (19) = happyShift action_11
action_21 (20) = happyShift action_12
action_21 (21) = happyShift action_13
action_21 (6) = happyGoto action_25
action_21 (8) = happyGoto action_17
action_21 (9) = happyGoto action_18
action_21 (11) = happyGoto action_26
action_21 _ = happyFail

action_22 _ = happyReduce_11

action_23 _ = happyReduce_2

action_24 _ = happyReduce_19

action_25 _ = happyReduce_20

action_26 (12) = happyShift action_19
action_26 (14) = happyShift action_20
action_26 (15) = happyShift action_21
action_26 (16) = happyShift action_31
action_26 (17) = happyShift action_22
action_26 (18) = happyShift action_10
action_26 (19) = happyShift action_11
action_26 (20) = happyShift action_12
action_26 (21) = happyShift action_13
action_26 (6) = happyGoto action_30
action_26 (8) = happyGoto action_17
action_26 (9) = happyGoto action_18
action_26 _ = happyFail

action_27 _ = happyReduce_8

action_28 _ = happyReduce_7

action_29 _ = happyReduce_12

action_30 _ = happyReduce_21

action_31 _ = happyReduce_13

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 _
	_
	 =  HappyAbsSyn5
		 (PComment
	)

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (PPack happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyTerminal (LSymbol happy_var_1))
	 =  HappyAbsSyn5
		 (PSymbol happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  6 happyReduction_7
happyReduction_7 _
	_
	 =  HappyAbsSyn6
		 (PComment
	)

happyReduce_8 = happySpecReduce_2  6 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (PUnpack happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  6 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  6 happyReduction_11
happyReduction_11 (HappyTerminal (LSymbol happy_var_1))
	 =  HappyAbsSyn6
		 (PSymbol happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn10  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  8 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  9 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn9
		 (PNothing
	)

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyTerminal (LInteger happy_var_1))
	 =  HappyAbsSyn9
		 (PInteger happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  9 happyReduction_16
happyReduction_16 (HappyTerminal (LCharacter happy_var_1))
	 =  HappyAbsSyn9
		 (PCharacter happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  9 happyReduction_17
happyReduction_17 (HappyTerminal (LString happy_var_1))
	 =  HappyAbsSyn9
		 (PString happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  10 happyReduction_18
happyReduction_18 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  10 happyReduction_19
happyReduction_19 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (PApply happy_var_1 happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  11 happyReduction_20
happyReduction_20 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_2  11 happyReduction_21
happyReduction_21 (HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (PApply happy_var_1 happy_var_2
	)
happyReduction_21 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 22 22 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	LComment -> cont 12;
	LPack -> cont 13;
	LUnpack -> cont 14;
	LOpen -> cont 15;
	LClose -> cont 16;
	LSymbol happy_dollar_dollar -> cont 17;
	LNothing -> cont 18;
	LInteger happy_dollar_dollar -> cont 19;
	LCharacter happy_dollar_dollar -> cont 20;
	LString happy_dollar_dollar -> cont 21;
	_ -> happyError' (tk:tks)
	}

happyError_ 22 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Lexeme)] -> HappyIdentity a
happyError' = HappyIdentity . eigenfail

eigenparse tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


data Parse = PComment
           | PPack Parse
           | PUnpack Parse
           | PApply Parse Parse
           | PSymbol String
           --
           | PNothing
           | PInteger Integer
           | PCharacter Char
           | PString String
           deriving Show

eigenfail :: [Lexeme] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<command-line>" #-}





# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4














# 1 "/usr/include/x86_64-linux-gnu/bits/predefs.h" 1 3 4

# 18 "/usr/include/x86_64-linux-gnu/bits/predefs.h" 3 4












# 31 "/usr/include/stdc-predef.h" 2 3 4








# 5 "<command-line>" 2
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 45 "templates/GenericTemplate.hs" #-}








{-# LINE 66 "templates/GenericTemplate.hs" #-}

{-# LINE 76 "templates/GenericTemplate.hs" #-}

{-# LINE 85 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 154 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 255 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--	trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 321 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
