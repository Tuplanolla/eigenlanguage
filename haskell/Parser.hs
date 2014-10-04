{-# OPTIONS_GHC -w #-}
module Parser (eigenparse) where

import Common (Expression (..), Structure (..), Token (..))

-- parser produced by Happy Version 1.19.0

data HappyAbsSyn t5 t6 t7 t8 t9 t10 t11 t12 t13 t14 t15
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
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14
	| HappyAbsSyn15 t15

action_0 (16) = happyShift action_8
action_0 (17) = happyShift action_9
action_0 (19) = happyShift action_10
action_0 (21) = happyShift action_11
action_0 (23) = happyShift action_12
action_0 (24) = happyShift action_13
action_0 (25) = happyShift action_14
action_0 (26) = happyShift action_15
action_0 (4) = happyGoto action_16
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 (10) = happyGoto action_6
action_0 (11) = happyGoto action_7
action_0 _ = happyReduce_2

action_1 (16) = happyShift action_8
action_1 (17) = happyShift action_9
action_1 (19) = happyShift action_10
action_1 (21) = happyShift action_11
action_1 (23) = happyShift action_12
action_1 (24) = happyShift action_13
action_1 (25) = happyShift action_14
action_1 (26) = happyShift action_15
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 (10) = happyGoto action_6
action_1 (11) = happyGoto action_7
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (16) = happyShift action_8
action_3 (17) = happyShift action_9
action_3 (19) = happyShift action_10
action_3 (21) = happyShift action_11
action_3 (23) = happyShift action_12
action_3 (24) = happyShift action_13
action_3 (25) = happyShift action_14
action_3 (26) = happyShift action_15
action_3 (7) = happyGoto action_28
action_3 (8) = happyGoto action_5
action_3 (10) = happyGoto action_6
action_3 (11) = happyGoto action_7
action_3 _ = happyReduce_3

action_4 _ = happyReduce_4

action_5 _ = happyReduce_8

action_6 _ = happyReduce_9

action_7 _ = happyReduce_10

action_8 (16) = happyShift action_8
action_8 (17) = happyShift action_9
action_8 (19) = happyShift action_10
action_8 (21) = happyShift action_11
action_8 (23) = happyShift action_12
action_8 (24) = happyShift action_13
action_8 (25) = happyShift action_14
action_8 (26) = happyShift action_15
action_8 (7) = happyGoto action_27
action_8 (8) = happyGoto action_5
action_8 (10) = happyGoto action_6
action_8 (11) = happyGoto action_7
action_8 _ = happyFail

action_9 (16) = happyShift action_23
action_9 (18) = happyShift action_24
action_9 (19) = happyShift action_25
action_9 (23) = happyShift action_26
action_9 (24) = happyShift action_13
action_9 (25) = happyShift action_14
action_9 (26) = happyShift action_15
action_9 (11) = happyGoto action_20
action_9 (12) = happyGoto action_21
action_9 (13) = happyGoto action_22
action_9 _ = happyFail

action_10 (16) = happyShift action_8
action_10 (17) = happyShift action_9
action_10 (19) = happyShift action_10
action_10 (21) = happyShift action_11
action_10 (23) = happyShift action_12
action_10 (24) = happyShift action_13
action_10 (25) = happyShift action_14
action_10 (26) = happyShift action_15
action_10 (5) = happyGoto action_19
action_10 (6) = happyGoto action_3
action_10 (7) = happyGoto action_4
action_10 (8) = happyGoto action_5
action_10 (10) = happyGoto action_6
action_10 (11) = happyGoto action_7
action_10 _ = happyReduce_2

action_11 (16) = happyShift action_8
action_11 (17) = happyShift action_9
action_11 (19) = happyShift action_10
action_11 (21) = happyShift action_11
action_11 (23) = happyShift action_12
action_11 (24) = happyShift action_13
action_11 (25) = happyShift action_14
action_11 (26) = happyShift action_15
action_11 (7) = happyGoto action_17
action_11 (8) = happyGoto action_5
action_11 (9) = happyGoto action_18
action_11 (10) = happyGoto action_6
action_11 (11) = happyGoto action_7
action_11 _ = happyReduce_13

action_12 _ = happyReduce_11

action_13 _ = happyReduce_16

action_14 _ = happyReduce_17

action_15 _ = happyReduce_18

action_16 (27) = happyAccept
action_16 _ = happyFail

action_17 (16) = happyShift action_8
action_17 (17) = happyShift action_9
action_17 (19) = happyShift action_10
action_17 (21) = happyShift action_11
action_17 (23) = happyShift action_12
action_17 (24) = happyShift action_13
action_17 (25) = happyShift action_14
action_17 (26) = happyShift action_15
action_17 (7) = happyGoto action_17
action_17 (8) = happyGoto action_5
action_17 (9) = happyGoto action_36
action_17 (10) = happyGoto action_6
action_17 (11) = happyGoto action_7
action_17 _ = happyReduce_13

action_18 (22) = happyShift action_35
action_18 _ = happyFail

action_19 (20) = happyShift action_34
action_19 _ = happyFail

action_20 _ = happyReduce_22

action_21 _ = happyReduce_7

action_22 _ = happyReduce_21

action_23 (16) = happyShift action_23
action_23 (18) = happyShift action_24
action_23 (19) = happyShift action_25
action_23 (23) = happyShift action_26
action_23 (24) = happyShift action_13
action_23 (25) = happyShift action_14
action_23 (26) = happyShift action_15
action_23 (11) = happyGoto action_20
action_23 (12) = happyGoto action_33
action_23 (13) = happyGoto action_22
action_23 _ = happyFail

action_24 (16) = happyShift action_8
action_24 (17) = happyShift action_9
action_24 (19) = happyShift action_10
action_24 (21) = happyShift action_11
action_24 (23) = happyShift action_12
action_24 (24) = happyShift action_13
action_24 (25) = happyShift action_14
action_24 (26) = happyShift action_15
action_24 (7) = happyGoto action_32
action_24 (8) = happyGoto action_5
action_24 (10) = happyGoto action_6
action_24 (11) = happyGoto action_7
action_24 _ = happyFail

action_25 (16) = happyShift action_23
action_25 (18) = happyShift action_24
action_25 (19) = happyShift action_25
action_25 (23) = happyShift action_26
action_25 (24) = happyShift action_13
action_25 (25) = happyShift action_14
action_25 (26) = happyShift action_15
action_25 (11) = happyGoto action_20
action_25 (12) = happyGoto action_29
action_25 (13) = happyGoto action_22
action_25 (14) = happyGoto action_30
action_25 (15) = happyGoto action_31
action_25 _ = happyReduce_25

action_26 _ = happyReduce_23

action_27 _ = happyReduce_6

action_28 _ = happyReduce_5

action_29 _ = happyReduce_27

action_30 (20) = happyShift action_38
action_30 _ = happyFail

action_31 (16) = happyShift action_23
action_31 (18) = happyShift action_24
action_31 (19) = happyShift action_25
action_31 (23) = happyShift action_26
action_31 (24) = happyShift action_13
action_31 (25) = happyShift action_14
action_31 (26) = happyShift action_15
action_31 (11) = happyGoto action_20
action_31 (12) = happyGoto action_37
action_31 (13) = happyGoto action_22
action_31 _ = happyReduce_26

action_32 _ = happyReduce_20

action_33 _ = happyReduce_19

action_34 _ = happyReduce_15

action_35 _ = happyReduce_12

action_36 _ = happyReduce_14

action_37 _ = happyReduce_28

action_38 _ = happyReduce_24

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_0  5 happyReduction_2
happyReduction_2  =  HappyAbsSyn5
		 (SNothing
	)

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  6 happyReduction_4
happyReduction_4 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_2  6 happyReduction_5
happyReduction_5 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (SPair happy_var_1 happy_var_2
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  7 happyReduction_6
happyReduction_6 _
	_
	 =  HappyAbsSyn7
		 (SComment
	)

happyReduce_7 = happySpecReduce_2  7 happyReduction_7
happyReduction_7 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (SPack happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  7 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  7 happyReduction_10
happyReduction_10 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyTerminal (TSymbol happy_var_1))
	 =  HappyAbsSyn7
		 (SSymbol happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  8 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (SPack (SList happy_var_2)
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_0  9 happyReduction_13
happyReduction_13  =  HappyAbsSyn9
		 ([]
	)

happyReduce_14 = happySpecReduce_2  9 happyReduction_14
happyReduction_14 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 : happy_var_2
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  10 happyReduction_15
happyReduction_15 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (happy_var_2
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  11 happyReduction_16
happyReduction_16 (HappyTerminal (TInteger happy_var_1))
	 =  HappyAbsSyn11
		 (SInteger happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  11 happyReduction_17
happyReduction_17 (HappyTerminal (TCharacter happy_var_1))
	 =  HappyAbsSyn11
		 (SCharacter happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  11 happyReduction_18
happyReduction_18 (HappyTerminal (TString happy_var_1))
	 =  HappyAbsSyn11
		 (SPack (SString happy_var_1)
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  12 happyReduction_19
happyReduction_19 _
	_
	 =  HappyAbsSyn12
		 (SComment
	)

happyReduce_20 = happySpecReduce_2  12 happyReduction_20
happyReduction_20 (HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (SUnpack happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  12 happyReduction_22
happyReduction_22 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  12 happyReduction_23
happyReduction_23 (HappyTerminal (TSymbol happy_var_1))
	 =  HappyAbsSyn12
		 (SSymbol happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  13 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn13
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_0  14 happyReduction_25
happyReduction_25  =  HappyAbsSyn14
		 (SNothing
	)

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  15 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  15 happyReduction_28
happyReduction_28 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (SPair happy_var_1 happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 27 27 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TComment -> cont 16;
	TPack -> cont 17;
	TUnpack -> cont 18;
	TOpen -> cont 19;
	TClose -> cont 20;
	TListOpen -> cont 21;
	TListClose -> cont 22;
	TSymbol happy_dollar_dollar -> cont 23;
	TInteger happy_dollar_dollar -> cont 24;
	TCharacter happy_dollar_dollar -> cont 25;
	TString happy_dollar_dollar -> cont 26;
	_ -> happyError' (tk:tks)
	}

happyError_ 27 tk tks = happyError' tks
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
eigenexpress (SPack x) = EPair (ESymbol "`") (eigenexpress x)
eigenexpress (SUnpack x) = EPair (ESymbol ",") (eigenexpress x)
eigenexpress (SPair SComment SComment) = ENothing
eigenexpress (SPair SComment y) = eigenexpress y
eigenexpress (SPair x SComment) = eigenexpress x
eigenexpress (SPair x y) = EPair (eigenexpress x) (eigenexpress y)
eigenexpress (SSymbol x) = ESymbol x
eigenexpress (SList x) = foldr (EPair . eigenexpress) ENothing x
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
