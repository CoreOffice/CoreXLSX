#!/bin/bash

set -e 
set -o pipefail

pod repo update
pod lib lint --verbose
