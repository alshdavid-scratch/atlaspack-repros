#!/bin/bash

PATH_SCRIPT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
PATH_ROOT="$(dirname "$PATH_SCRIPT")"
COUNT=10
ENTRY="$PATH_SCRIPT/src/index.js"

export DEBUG_ASSET_GRAPH_DOT_STYLE="false" 
export DEBUG_ASSET_GRAPH_DOT_SORT="false" 

rm -rf "$PATH_SCRIPT/dot"
mkdir "$PATH_SCRIPT/dot"

for i in $(seq "$COUNT")
do
  echo BUILD $i
  export DEBUG_ASSET_GRAPH_DOT="$PATH_SCRIPT/dot/asset_graph.$i.dot" 

  rm -rf "$PATH_SCRIPT/.parcel-cache"
  rm -rf "$PATH_SCRIPT/dist"

  node "$PATH_SCRIPT/node_modules/@atlaspack/cli/bin/dev-bin.js" \
    build \
      --no-source-maps \
      --feature-flag atlaspackV3=true \
      "$ENTRY" | tee

  rm -rf "$PATH_SCRIPT/_dist/dist-$i"

  for f in $PATH_SCRIPT/dot/*; do
    base=$(basename $f)
    for c in $PATH_SCRIPT/dot/*; do
      HAS_DIFF=$(diff "$f" "$c")
      if [ "$HAS_DIFF" != "" ]; then
        echo FAILED
        echo   "$f"
        echo   "$c"
        exit 0
      fi
    done
    echo OK $base
  done
done

# for f in $PATH_SCRIPT/dot/*; do
#   base=$(basename $f)
#   for c in $PATH_SCRIPT/dot/*; do
#     HAS_DIFF=$(diff "$f" "$c")
#     if [ "$HAS_DIFF" != "" ]; then
#       echo FAILED
#       echo   "$f"
#       echo   "$c"
#       exit 0
#     fi
#   done
#   echo OK $base
# done
