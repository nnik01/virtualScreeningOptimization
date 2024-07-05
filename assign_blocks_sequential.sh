#!/bin/bash

find ../gdb9_properties/ -name *.prop -type f -exec ./assign_block.sh "{}" \;
