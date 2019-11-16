#!/usr/bin/env python3

import subprocess as sp
from pathlib import Path

run_types = [
    "sr", # sequential read
    "sw", # sequential write
    "wr", # sequential write / read
    "rw", # random write
    "rr", # random read
    "zw", # zipf-distribution write
    "zr", # zipf read
]

gb_file_size = 2
kb_IO_size = 4
threads = 1

# sudo ./run.sh iotest sw 2G 4K 1 #sequential write, 2GB file with 4K IO and 1 thread
import os
for run_type in run_types:
    print("running {} with filesize {} and io size {}".format(run_type, gb_file_size, kb_IO_size))
    os.chdir("./libfs/tests")
    completed = sp.run(["sudo", "./run.sh", "iotest", run_type, "{}G".format(gb_file_size), "{}K".format(kb_IO_size), str(threads)], encoding="utf-8", stdout=sp.PIPE, stderr=sp.PIPE)
    os.chdir("../../")
    if completed.returncode is not 0:
        print("Failed to complete (error code {})".format(completed.returncode))
    else:
        print("Completed")
    print(completed.stdout)
    if completed.stderr:
        print("@" * 10 + "ERROR" + "@" * 10)
        print(completed.stderr)
    print("")
