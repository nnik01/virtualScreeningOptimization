#!/bin/bash

parallel -j12 'obprop gdb9_pdbqt/{} > gdb9_properties/{.}.prop' < list_pdbqt
