#!/bin/bash

module load Flye/gcc-11.4.1/2.9.6

# create output directory
DATA_DIR="./data/SRR33939694.fastq.gz"
OUT_DIR="./assemblies/assembly_module"
mkdir -p "$OUT_DIR"

# remove everything in the output directory
rm -rf "$OUT_DIR"/*

# process data
flye --nano-hq "$DATA_DIR" --out-dir "$OUT_DIR" --genome-size 50k --meta --threads 6

# clean up
find "$OUT_DIR" -mindepth 1 -depth ! -name 'assembly.fasta' ! -name 'flye.log' -delete
mv "$OUT_DIR/assembly.fasta" "$OUT_DIR/module_assembly.fasta"
mv "$OUT_DIR/flye.log" "$OUT_DIR/module_flye.log"

# deactivate
module unload Flye/gcc-11.4.1/2.9.6
