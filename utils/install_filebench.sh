#!/bin/bash

# installs the filebench benchmark suite
# fail on first error
set -e

# step 0 install required packages (bison for yacc, flex for lex)
sudo apt install automake libtool bison flex

# step 1: generate autotool scripts
cd bench/filebench
libtoolize
aclocal
autoheader
automake --add-missing
autoconf
# step 2  Compilation and installation

# add path to mlfs
export CPATH="$HOME/strata/libfs/src/:$CPATH"
#export LD_LIBRARY_PATH=":$LD_LIBRARY_PATH"

./configure
make -j
sudo make install

