#!/bin/bash

set -ex
set -o pipefail

brew upgrade
brew install swiftformat swiftlint

swiftformat --lint --verbose .
swiftlint
