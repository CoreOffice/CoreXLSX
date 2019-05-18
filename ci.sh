#!/bin/sh

if [ -n "$TESTS_PATH" ]; then
  swift test
fi

     
carthage bootstrap
xcodebuild build -scheme CoreXLSXiOS \
  -sdk iphonesimulator -destination "$IOS_DEVICE" | xcpretty
xcodebuild build -scheme CoreXSLXtvOS \
  -sdk appletvsimulator -destination "$TVOS_DEVICE" | xcpretty

if [ -n "$CODECOV_JOB" ]; then
  xcodebuild test -enableCodeCoverage YES -scheme CoreXLSX \
    -sdk macosx | xcpretty
else 
  xcodebuild test -scheme CoreXLSX \
    -sdk macosx | xcpretty
fi