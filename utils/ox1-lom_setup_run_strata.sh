#!/bin/bash

# runs strata on the ox1-lom pig machine
# fail on first error
set -e

# step 0 install required packages
sudo apt install ndctl pciutils

# step 2 of running strata - use DEV / DAX emulation
cd utils
sudo ./use_dax.sh bind
# step 3 of running strata (make sure you've rebuilt libfs and kernfs) 
echo "Make sure that libfs and kernfs have been built"

# step 4 of running strata: setup UIO for SPDK
sudo ./uio_setup.sh $(whoami) config
cd ../

# step 5 of running strata: format storage
cd libfs
# we set storage sizes here. I'm guessing we just run through it for each device
set +e
echo -e "\nMaking NVM shared area"
sudo ./bin/mkfs.mlfs 1
echo -e "\nMaking SSD shared area"
sudo ./bin/mkfs.mlfs 2
echo -e "\nMaking HDD shared area"
sudo ./bin/mkfs.mlfs 3
echo -e "\nMaking operation log of processes"
sudo ./bin/mkfs.mlfs 4
set -e
