module Erl.ModuleName.Symbol (
  ModuleName
, moduleName
, NativeModuleName
, nativeModuleName

, class MungeModule
, munge
) where

import Data.Symbol (class IsSymbol, SProxy(..))
import Erl.Atom.Symbol (Atom, atom)
import Prim.Symbol as Symbol

newtype ModuleName (name :: Symbol) = ModuleName (Atom name)

moduleName :: forall s. IsSymbol s => ModuleName s
moduleName = ModuleName atom

newtype NativeModuleName (name :: Symbol) = NativeModuleName (Atom name)

nativeModuleName :: forall name munged. IsSymbol name => IsSymbol munged => MungeModule name munged => ModuleName name -> NativeModuleName munged
nativeModuleName (ModuleName _) = NativeModuleName (atom :: Atom munged)

class MungeModule (name :: Symbol) (munged :: Symbol) | name -> munged where
  munge :: SProxy name -> SProxy munged

instance nilMungeModule :: MungeModule "" "" where
  munge _  = SProxy
else instance consMungeModule ::
  ( Symbol.Cons h t string
  , Symbol.Append out1 "@ps" out2
  , Munge2 h t out1) => MungeModule string out2 where
  munge _ = SProxy

class Munge1 (head :: Symbol) (tail :: Symbol) (out :: Symbol) | head tail -> out

instance munge1Nil :: Munge1 h "" h
else instance munge1Underscore :: (
    Symbol.Cons h t input
  , Munge2 h t mungedTail
  , Symbol.Cons "_" mungedTail output
) => Munge1 "." input output
else instance munge1Cons :: (
    Symbol.Cons h t input
  , Munge1 h t mungedTail
  , Symbol.Cons c mungedTail output
) => Munge1 c input output

class Munge2 (head :: Symbol) (tail :: Symbol) (out :: Symbol) | head tail -> out
instance munge2Nil :: (ToUpper a b) => Munge2 a "" b
else instance munge2Cons :: 
  ( Symbol.Cons h t input
  , ToUpper co c
  , Munge1 h t mungedTail
  , Symbol.Cons co mungedTail output
  ) => Munge2 c input output

class ToUpper (c :: Symbol) (uc :: Symbol) | c -> uc, uc -> c

instance toUpperA :: ToUpper "a" "A"
instance toUpperB :: ToUpper "b" "B"
instance toUpperC :: ToUpper "c" "C"
instance toUpperD :: ToUpper "d" "D"
instance toUpperE :: ToUpper "e" "E"
instance toUpperF :: ToUpper "f" "F"
instance toUpperG :: ToUpper "g" "G"
instance toUpperH :: ToUpper "h" "H"
instance toUpperI :: ToUpper "i" "I"
instance toUpperJ :: ToUpper "j" "J"
instance toUpperK :: ToUpper "k" "K"
instance toUpperL :: ToUpper "l" "L"
instance toUpperM :: ToUpper "m" "M"
instance toUpperN :: ToUpper "n" "N"
instance toUpperO :: ToUpper "o" "O"
instance toUpperP :: ToUpper "p" "P"
instance toUpperQ :: ToUpper "q" "Q"
instance toUpperR :: ToUpper "r" "R"
instance toUpperS :: ToUpper "s" "S"
instance toUpperT :: ToUpper "t" "T"
instance toUpperU :: ToUpper "u" "U"
instance toUpperV :: ToUpper "v" "V"
instance toUpperW :: ToUpper "w" "W"
instance toUpperX :: ToUpper "x" "X"
instance toUpperY :: ToUpper "y" "Y"
instance toUpperZ :: ToUpper "z" "Z"