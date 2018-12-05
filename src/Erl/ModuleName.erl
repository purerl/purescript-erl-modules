-module(erl_moduleName@foreign).
-export([atomToString/1]).

atomToString(Mn) -> atom_to_binary(Mn, utf8).