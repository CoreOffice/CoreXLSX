#!/bin/sh

brew update
brew install swiftformat
brew outdated swiftlint || brew upgrade swiftlint
pod repo update

swiftformat --lint --verbose .
swiftlint
pod lib lint --verbose