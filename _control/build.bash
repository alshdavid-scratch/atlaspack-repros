# Usage:
# bash ./build.bash
#
# Options:
# env ATLASPACK_DEV=true bash ./build.bash
# env ATLASPACK_DEV=true ATLASPACK_V3=true bash ./build.bash

PATH_SCRIPT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

rm -rf "$PATH_SCRIPT/.parcel-cache"
rm -rf "$PATH_SCRIPT/.atlaspack-cache"
rm -rf "$PATH_SCRIPT/dist"

if [ "$ATLASPACK_DEV" == "true" ]; then
  echo "============================="
  echo "== USING ATLASPACK SOURCES =="
  echo "============================="
  ATLASPACK_BIN="$PATH_SCRIPT/node_modules/@atlaspack/cli/bin/dev-bin.js"
else
  ATLASPACK_BIN="$PATH_SCRIPT/node_modules/@atlaspack/cli/bin/atlaspack.js"
fi

if [ "$ATLASPACK_V3" == "true" ]; then
  FF_ATLASPACK_V3="true"
else
  FF_ATLASPACK_V3="false"
fi

node "$ATLASPACK_BIN" \
  build \
    --no-source-maps \
    --feature-flag atlaspackV3="$FF_ATLASPACK_V3" \
    "$PATH_SCRIPT/src/index.html" | tee