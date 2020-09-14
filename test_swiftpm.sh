#!/bin/bash

set -ex
set -o pipefail

TESTS_PATH=$PWD/Tests/CoreXLSXTests swift test --parallel
