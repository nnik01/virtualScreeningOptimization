#!/bin/bash

# Assign block numbers depending on conditions.

MOLECULE="$1"
FILENAME=$(basename $MOLECULE)
LIGANDNAME="ligand_$(basename $MOLECULE .prop)"
NUM_ATOMS=$(awk '/num_atoms/ {print $2}' $MOLECULE)
PSA=$(awk '/PSA/ {print $2}' $MOLECULE)

awk -v FILENAME=$FILENAME -v LIGANDNAME=$LIGANDNAME -v NUM_ATOMS=$NUM_ATOMS -v PSA=$PSA 'BEGIN { 
if ((NUM_ATOMS<=17)                 && (PSA<=24.6))                print LIGANDNAME" "NUM_ATOMS" "PSA" 1"; 
if ((17<NUM_ATOMS)&&(NUM_ATOMS<=19) && (PSA<=24.6))                print LIGANDNAME" "NUM_ATOMS" "PSA" 2"; 
if ((19<NUM_ATOMS)&&(NUM_ATOMS<=21) && (PSA<=24.6))                print LIGANDNAME" "NUM_ATOMS" "PSA" 3"; 
if ((21<NUM_ATOMS)&&(NUM_ATOMS<=31) && (PSA<=24.6))                print LIGANDNAME" "NUM_ATOMS" "PSA" 4"; 
if ((NUM_ATOMS<=17)                 && (24.6<PSA)&&(PSA<=38.05))   print LIGANDNAME" "NUM_ATOMS" "PSA" 5"; 
if ((17<NUM_ATOMS)&&(NUM_ATOMS<=19) && (24.6<PSA)&&(PSA<=38.05))   print LIGANDNAME" "NUM_ATOMS" "PSA" 6"; 
if ((19<NUM_ATOMS)&&(NUM_ATOMS<=21) && (24.6<PSA)&&(PSA<=38.05))   print LIGANDNAME" "NUM_ATOMS" "PSA" 7";
if ((21<NUM_ATOMS)&&(NUM_ATOMS<=31) && (24.6<PSA)&&(PSA<=38.05))   print LIGANDNAME" "NUM_ATOMS" "PSA" 8";
if ((NUM_ATOMS<=17)                 && (38.05<PSA)&&(PSA<=52.04))  print LIGANDNAME" "NUM_ATOMS" "PSA" 9"; 
if ((17<NUM_ATOMS)&&(NUM_ATOMS<=19) && (38.05<PSA)&&(PSA<=52.04))  print LIGANDNAME" "NUM_ATOMS" "PSA" 10"; 
if ((19<NUM_ATOMS)&&(NUM_ATOMS<=21) && (38.05<PSA)&&(PSA<=52.04))  print LIGANDNAME" "NUM_ATOMS" "PSA" 11";
if ((21<NUM_ATOMS)&&(NUM_ATOMS<=31) && (38.05<PSA)&&(PSA<=52.04))  print LIGANDNAME" "NUM_ATOMS" "PSA" 12";
if ((NUM_ATOMS<=17)                 && (52.04<PSA)&&(PSA<=118.35)) print LIGANDNAME" "NUM_ATOMS" "PSA" 13"; 
if ((17<NUM_ATOMS)&&(NUM_ATOMS<=19) && (52.04<PSA)&&(PSA<=118.35)) print LIGANDNAME" "NUM_ATOMS" "PSA" 14"; 
if ((19<NUM_ATOMS)&&(NUM_ATOMS<=21) && (52.04<PSA)&&(PSA<=118.35)) print LIGANDNAME" "NUM_ATOMS" "PSA" 15";
if ((21<NUM_ATOMS)&&(NUM_ATOMS<=31) && (52.04<PSA)&&(PSA<=118.35)) print LIGANDNAME" "NUM_ATOMS" "PSA" 16";
}' 
