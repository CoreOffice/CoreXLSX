#!/bin/bash

set -e 
set -o pipefail

sudo xcode-select --switch /Applications/$1.app/Contents/Developer

xcodebuild -version
carthage bootstrap
xcodebuild build -scheme CoreXLSXiOS \
  -sdk iphonesimulator -destination "$IOS_DEVICE" | xcpretty
xcodebuild build -scheme CoreXLSXtvOS \
  -sdk appletvsimulator -destination "$TVOS_DEVICE" | xcpretty

if [ -n "$CODECOV_JOB" ]; then
  xcodebuild test -enableCodeCoverage YES -scheme CoreXLSX \
    -sdk macosx | xcpretty
  bash <(curl -s https://codecov.io/bash)
else 
  xcodebuild test -scheme CoreXLSX \
    -sdk macosx | xcpretty
fi
