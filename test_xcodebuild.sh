#!/bin/bash

sudo xcode-select --switch /Applications/$1.app/Contents/Developer

xcodebuild -version
carthage bootstrap
set -o pipefail && xcodebuild build -scheme CoreXLSXiOS \
  -sdk iphonesimulator -destination "$IOS_DEVICE" | xcpretty
set -o pipefail && xcodebuild build -scheme CoreXLSXtvOS \
  -sdk appletvsimulator -destination "$TVOS_DEVICE" | xcpretty

if [ -n "$CODECOV_JOB" ]; then
  set -o pipefail && xcodebuild test -enableCodeCoverage YES -scheme CoreXLSX \
    -sdk macosx | xcpretty
  bash <(curl -s https://codecov.io/bash)
else 
  set -o pipefail && xcodebuild test -scheme CoreXLSX \
    -sdk macosx | xcpretty
fi
