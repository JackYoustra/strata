#!/bin/bash

# runs strata on the ox1-lom pig machine
# fail on first error
set -e

# step 0: dependencies
sudo apt install libssl-dev

# step 7
cd libfs/tests
make -j
sudo ./run.sh iotest sw 2G 4K 1 #sequential write, 2GB file with 4K IO and 1 thread

