#!/bin/bash

# runs strata's kernfs on the ox1-lom pig machine
# fail on first error
set -e

# step 0 install required packages

# step 6 of running strata
cd kernfs/tests
make -j
sudo ./run.sh kernfs
