{-# OPTIONS_GHC -w #-}
module Parser (eigenparse) where

import Common (Expression (..), Structure (..), Token (..))

-- parser produced by Happy Version 1.19.0

data HappyAbsSyn t5 t6 t7 t8 t9 t10 t11 t12
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 (Structure)
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12

action_0 (13) = happyShift action_8
action_0 (14) = happyShift action_9
action_0 (15) = happyShift action_10
action_0 (16) = happyShift action_11
action_0 (18) = happyShift action_12
action_0 (20) = happyShift action_13
action_0 (21) = happyShift action_14
action_0 (22) = happyShift action_15
action_0 (23) = happyShift action_16
action_0 (4) = happyGoto action_17
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (10) = happyGoto action_6
action_0 (12) = happyGoto action_7
action_0 _ = happyReduce_11

action_1 (13) = happyShift action_8
action_1 (14) = happyShift action_9
action_1 (15) = happyShift action_10
action_1 (16) = happyShift action_11
action_1 (18) = happyShift action_12
action_1 (20) = happyShift action_13
action_1 (21) = happyShift action_14
action_1 (22) = happyShift action_15
action_1 (23) = happyShift action_16
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (10) = happyGoto action_6
action_1 (12) = happyGoto action_7
action_1 _ = happyFail

action_2 _ = happyReduce_15

action_3 _ = happyReduce_5

action_4 _ = happyReduce_6

action_5 _ = happyReduce_1

action_6 (13) = happyShift action_8
action_6 (14) = happyShift action_9
action_6 (15) = happyShift action_10
action_6 (16) = happyShift action_11
action_6 (18) = happyShift action_12
action_6 (20) = happyShift action_13
action_6 (21) = happyShift action_14
action_6 (22) = happyShift action_15
action_6 (23) = happyShift action_16
action_6 (5) = happyGoto action_25
action_6 (6) = happyGoto action_3
action_6 (7) = happyGoto action_4
action_6 (12) = happyGoto action_7
action_6 _ = happyReduce_12

action_7 _ = happyReduce_7

action_8 (13) = happyShift action_8
action_8 (14) = happyShift action_9
action_8 (15) = happyShift action_10
action_8 (16) = happyShift action_11
action_8 (18) = happyShift action_12
action_8 (20) = happyShift action_13
action_8 (21) = happyShift action_14
action_8 (22) = happyShift action_15
action_8 (23) = happyShift action_16
action_8 (5) = happyGoto action_24
action_8 (6) = happyGoto action_3
action_8 (7) = happyGoto action_4
action_8 (12) = happyGoto action_7
action_8 _ = happyFail

action_9 (13) = happyShift action_8
action_9 (14) = happyShift action_9
action_9 (15) = happyShift action_10
action_9 (16) = happyShift action_11
action_9 (18) = happyShift action_12
action_9 (20) = happyShift action_13
action_9 (21) = happyShift action_14
action_9 (22) = happyShift action_15
action_9 (23) = happyShift action_16
action_9 (5) = happyGoto action_23
action_9 (6) = happyGoto action_3
action_9 (7) = happyGoto action_4
action_9 (12) = happyGoto action_7
action_9 _ = happyFail

action_10 (13) = happyShift action_8
action_10 (14) = happyShift action_9
action_10 (15) = happyShift action_10
action_10 (16) = happyShift action_11
action_10 (18) = happyShift action_12
action_10 (20) = happyShift action_13
action_10 (21) = happyShift action_14
action_10 (22) = happyShift action_15
action_10 (23) = happyShift action_16
action_10 (5) = happyGoto action_22
action_10 (6) = happyGoto action_3
action_10 (7) = happyGoto action_4
action_10 (12) = happyGoto action_7
action_10 _ = happyFail

action_11 (13) = happyShift action_8
action_11 (14) = happyShift action_9
action_11 (15) = happyShift action_10
action_11 (16) = happyShift action_11
action_11 (18) = happyShift action_12
action_11 (20) = happyShift action_13
action_11 (21) = happyShift action_14
action_11 (22) = happyShift action_15
action_11 (23) = happyShift action_16
action_11 (5) = happyGoto action_2
action_11 (6) = happyGoto action_3
action_11 (7) = happyGoto action_4
action_11 (8) = happyGoto action_21
action_11 (10) = happyGoto action_6
action_11 (12) = happyGoto action_7
action_11 _ = happyReduce_11

action_12 (13) = happyShift action_8
action_12 (14) = happyShift action_9
action_12 (15) = happyShift action_10
action_12 (16) = happyShift action_11
action_12 (18) = happyShift action_12
action_12 (20) = happyShift action_13
action_12 (21) = happyShift action_14
action_12 (22) = happyShift action_15
action_12 (23) = happyShift action_16
action_12 (5) = happyGoto action_18
action_12 (6) = happyGoto action_3
action_12 (7) = happyGoto action_4
action_12 (9) = happyGoto action_19
action_12 (11) = happyGoto action_20
action_12 (12) = happyGoto action_7
action_12 _ = happyReduce_13

action_13 _ = happyReduce_8

action_14 _ = happyReduce_19

action_15 _ = happyReduce_20

action_16 _ = happyReduce_21

action_17 (24) = happyAccept
action_17 _ = happyFail

action_18 (13) = happyShift action_8
action_18 (14) = happyShift action_9
action_18 (15) = happyShift action_10
action_18 (16) = happyShift action_11
action_18 (18) = happyShift action_12
action_18 (20) = happyShift action_13
action_18 (21) = happyShift action_14
action_18 (22) = happyShift action_15
action_18 (23) = happyShift action_16
action_18 (5) = happyGoto action_18
action_18 (6) = happyGoto action_3
action_18 (7) = happyGoto action_4
action_18 (11) = happyGoto action_28
action_18 (12) = happyGoto action_7
action_18 _ = happyReduce_17

action_19 (19) = happyShift action_27
action_19 _ = happyFail

action_20 _ = happyReduce_14

action_21 (17) = happyShift action_26
action_21 _ = happyFail

action_22 _ = happyReduce_4

action_23 _ = happyReduce_3

action_24 _ = happyReduce_2

action_25 _ = happyReduce_16

action_26 _ = happyReduce_9

action_27 _ = happyReduce_10

action_28 _ = happyReduce_18

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 _
	_
	 =  HappyAbsSyn5
		 (SComment
	)

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (SPair (SSymbol "`") happy_var_2
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (SPair (SSymbol ",") happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  5 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_1  5 happyReduction_7
happyReduction_7 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_7 _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  5 happyReduction_8
happyReduction_8 (HappyTerminal (TSymbol happy_var_1))
	 =  HappyAbsSyn5
		 (SSymbol happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  6 happyReduction_9
happyReduction_9 _
	(HappyAbsSyn8  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (happy_var_2
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (happy_var_2
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_0  8 happyReduction_11
happyReduction_11  =  HappyAbsSyn8
		 (SNothing
	)

happyReduce_12 = happySpecReduce_1  8 happyReduction_12
happyReduction_12 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  9 happyReduction_13
happyReduction_13  =  HappyAbsSyn9
		 (SNothing
	)

happyReduce_14 = happySpecReduce_1  9 happyReduction_14
happyReduction_14 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  10 happyReduction_15
happyReduction_15 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  10 happyReduction_16
happyReduction_16 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn10
		 (SPair happy_var_1 happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  11 happyReduction_17
happyReduction_17 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  11 happyReduction_18
happyReduction_18 (HappyAbsSyn11  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn11
		 (SPair happy_var_1 happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyTerminal (TInteger happy_var_1))
	 =  HappyAbsSyn12
		 (SInteger happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyTerminal (TCharacter happy_var_1))
	 =  HappyAbsSyn12
		 (SCharacter happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyTerminal (TString happy_var_1))
	 =  HappyAbsSyn12
		 (SPair (SSymbol "`") (SString happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 24 24 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TComment -> cont 13;
	TPack -> cont 14;
	TUnpack -> cont 15;
	TOpen -> cont 16;
	TClose -> cont 17;
	TDualOpen -> cont 18;
	TDualClose -> cont 19;
	TSymbol happy_dollar_dollar -> cont 20;
	TInteger happy_dollar_dollar -> cont 21;
	TCharacter happy_dollar_dollar -> cont 22;
	TString happy_dollar_dollar -> cont 23;
	_ -> happyError' (tk:tks)
	}

happyError_ 24 tk tks = happyError' tks
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
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . eigenfail

eigenstructure tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


eigenfail :: [Token] -> a
eigenfail (x : _) = error ("failed to parse: " ++ show x)
eigenfail _ = error "failed to parse"

eigenparse :: [Token] -> Expression
eigenparse = eigenexpress . eigenstructure

eigenexpress :: Structure -> Expression
eigenexpress SComment = ENothing
eigenexpress (SPair SComment SComment) = ENothing
eigenexpress (SPair SComment y) = eigenexpress y
eigenexpress (SPair x SComment) = eigenexpress x
eigenexpress (SPair x y) = EPair (eigenexpress x) (eigenexpress y)
eigenexpress (SSymbol x) = ESymbol x
eigenexpress SNothing = ENothing
eigenexpress (SInteger x) = EInteger x
eigenexpress (SCharacter x) = ECharacter x
eigenexpress (SString x) = foldr (EPair . ECharacter) ENothing x
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
