#!/bin/bash

set -e 
set -o pipefail

TESTS_PATH=$PWD/Tests/CoreXLSXTests swift test --parallel
