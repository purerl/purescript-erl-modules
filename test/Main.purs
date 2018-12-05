module Test.Main where

import Prelude

import Effect.Class.Console (log)
import Erl.Atom (atom)
import Erl.ModuleName (NativeModuleName(..), moduleName, nativeModuleName)
import Test.Assert (assertEqual)

main = do
  assertEqual {
    actual: nativeModuleName $ moduleName "Foo.Bar.Baz",
    expected: NativeModuleName $ atom "foo_bar_baz@ps"
  }
  assertEqual {
    actual: nativeModuleName $ moduleName "SingleThingyCamel",
    expected: NativeModuleName $ atom "singleThingyCamel@ps"
  }
  assertEqual {
    actual: nativeModuleName $ moduleName "ABC",
    expected: NativeModuleName $ atom "aBC@ps"
  }
  log "Tests pass, yay!"
  -- asse moduleName "Foo.Bar.Baz"