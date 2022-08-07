#!/bin/bash

set -e 
set -o pipefail

bundle install

cd Example && bundle exec pod install --repo-update && cd ..
bundle exec pod lib lint --allow-warnings --verbose
