#!/bin/bash

set -ex
set -o pipefail

rm '/usr/local/bin/swiftlint'
brew upgrade
brew install swiftformat swiftlint

swiftformat --lint --verbose .
swiftlint
