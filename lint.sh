#!/bin/bash

set -e 
set -o pipefail

brew update
brew install swiftformat

swiftformat --lint --verbose .
swiftlint
