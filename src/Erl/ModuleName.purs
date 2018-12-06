module Erl.ModuleName where

import Prelude

import Data.String (Pattern(..), joinWith, split, toLower)
import Data.String.CodeUnits (drop, take)
import Erl.Atom (Atom, atom, toString)

-- | A PureScript module name e.g. Foo.Bar
newtype ModuleName = ModuleName String

moduleName :: String -> ModuleName
moduleName = ModuleName

-- | Name of an actual Erlang module e.g. foo_bar
newtype NativeModuleName = NativeModuleName Atom

instance eqNativeModuleName :: Eq NativeModuleName where
  eq (NativeModuleName a) (NativeModuleName b) = eq a b

instance showNativeModuleName :: Show NativeModuleName where
  show (NativeModuleName a) = "(NativeModuleName " <> toString a <> ")"

nativeModuleName :: ModuleName -> NativeModuleName
nativeModuleName (ModuleName mn) =
  let name = mn
      modules = split (Pattern ".") name
      updateModule mod = toLower (take 1 mod) <> drop 1 mod
  in
  NativeModuleName $ atom $
    (joinWith "_" (updateModule <$> modules)) <> "@ps"
