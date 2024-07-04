#!/bin/bash

parallel -j12 './assign_block.sh gdb9_properties/{.}.prop' < list_prop
