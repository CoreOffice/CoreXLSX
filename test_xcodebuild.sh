#!/bin/bash

set -ex
set -o pipefail

sudo xcode-select --switch /Applications/$1.app/Contents/Developer

xcodebuild -version
xcodebuild test -scheme CoreXLSX \
  -sdk iphonesimulator -destination "$IOS_DEVICE" | xcpretty
xcodebuild test -scheme CoreXLSX \
  -sdk appletvsimulator -destination "$TVOS_DEVICE" | xcpretty

if [ -n "$CODECOV_JOB" ]; then
  xcodebuild test -enableCodeCoverage YES -scheme CoreXLSX \
    -destination platform=macOS | xcpretty
  bash <(curl -s https://codecov.io/bash)
else
  xcodebuild test -scheme CoreXLSX \
    -destination platform=macOS | xcpretty
fi
