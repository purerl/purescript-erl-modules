#!/bin/bash
SRCDIR=${1:-src}
MODULES=$(find "$SRCDIR" -name \*.purs -exec sed -rn '/^--/d; s/^module\s+([^ ]+)(\s+.*|$)/\1/p; T q ; q0; :q q1;' \{\} \;)

PURSFILE="$SRCDIR/ModuleNames.purs"
cat >$PURSFILE <<HEADER
module ModuleNames where

import Erl.ModuleName (ModuleName(..))

HEADER

for MODULE in $MODULES; do
    MODULE_TYPE=$(echo "$MODULE" | sed 's/\.//g')
    MODULE_IDENT=$(echo "$MODULE_TYPE" | sed -e 's/./\l\0/')
    cat >> $PURSFILE <<END

$MODULE_IDENT :: ModuleName
$MODULE_IDENT = ModuleName "$MODULE"
END
#     cat >> $PURSFILE <<END

# type $MODULE_TYPE = ModuleName "$MODULE"
# $MODULE_IDENT :: $MODULE_TYPE
# $MODULE_IDENT = ModuleName
# END
done