#!/bin/bash

brew update
brew install swiftformat swiftlint
pod repo update

swiftformat --lint --verbose .
swiftlint
pod lib lint --verbose