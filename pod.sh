#!/bin/bash

set -e 
set -o pipefail

cd Example && pod install --repo-update && cd ..
pod lib lint --verbose
