#!/bin/bash

# sets up the ox1-lom machine for development
# fail on first error
set -e

# step 0 install required packages
sudo apt install build-essential pkg-config libndctl-dev libdaxctl-dev autoconf cmake libcapstone-dev

# step 1 of building strata
./utils/change_dev_size.py 16 0 0 4 
# step 3 of building strata (dependent libraries)
cd libfs/lib
if cd nvml; then git pull; else git clone https://github.com/pmem/nvml; fi
cd ..
if cd syscall_intercept; then git pull; else git clone https://github.com/pmem/syscall_intercept.git; fi
cd ..
make -j

tar xvjf jemalloc-4.5.0.tar.bz2
cd jemalloc-4.5.0
./autogen.sh
./configure
make -j

# step 4 of building strata: LibFS
cd ../../../
cd libfs
make -j

# step 5 of building strata: KernelFS
cd kernfs
make -j
cd tests
make -j
cd ..
