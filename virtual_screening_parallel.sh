#!/bin/bash

LIGANDSDIR="$HOME/work/2024/Optimization/HiTViSc/gdb9_pdbqt"
LIGANDLIST="$HOME/work/2024/Optimization/HiTViSc/add_list_pdbqt"
RESULTSDIR="$HOME/work/2024/Optimization/HiTViSc/gdb9_docked"
AUTODOCKVINA="$HOME/work/2024/Optimization/HiTViSc/MolecularDocking/Software/vina_1.2.5_linux_x86_64"
RECEPTOR="$HOME/work/2024/Optimization/HiTViSc/MolecularDocking/RORa_Hydrogens.pdbqt"
CONFIG="$HOME/work/2024/Optimization/HiTViSc/MolecularDocking/config.txt"

parallel -j12 "$AUTODOCKVINA --receptor $RECEPTOR --ligand $LIGANDSDIR/{} --config $CONFIG --out $RESULTSDIR/{.}.out --num_modes 1 2>/dev/null | tail -1 > $RESULTSDIR/{.}.value" < $LIGANDLIST
