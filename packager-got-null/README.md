# Atlaspack Repro

## Packager `Got unexpected null`

This is a minimal reproduction of the packager bug where we get the following error:

```
@atlaspack/packager-js: Got unexpected null

  Error: Got unexpected null
      at nullthrows (packager-got-null/node_modules/nullthrows/nullthrows.js:7:15)
      at packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:933:51
      at Array.every (<anonymous>)
      at packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:932:35
      at Array.filter (<anonymous>)
      at ScopeHoistingPackager.buildAssetPrelude 
  (packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:922:60)
      at ScopeHoistingPackager.buildAsset 
  (packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:396:48)
      at ScopeHoistingPackager.visitAsset 
  (packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:351:17)
      at processAsset (packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:124:40)
      at packager-got-null/node_modules/@atlaspack/packager-js/lib/ScopeHoistingPackager.js:149:7
```

## Instructions

```bash
npm install
bash ./build.bash

# Options:
# env ATLASPACK_DEV=true bash ./build.bash
# env ATLASPACK_DEV=true ATLASPACK_V3=true bash ./build.bash
```

## Notes

- Only seems to happen with an html entry
- Requires a combination of dynamic and static re-exports
