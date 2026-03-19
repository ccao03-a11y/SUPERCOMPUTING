#!/bin/bash

# activate environment
module load miniforge3
source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh
conda activate flye-env

# create output directory
DATA_DIR="./data/SRR33939694.fastq.gz"
OUT_DIR="./assemblies/assembly_conda"
mkdir -p "$OUT_DIR"

# remove everything in the output directory
rm -rf "$OUT_DIR"/*

# process data
flye --nano-hq "$DATA_DIR" --out-dir "$OUT_DIR" --genome-size 50k --meta --threads 6

# clean up
find "$OUT_DIR" -mindepth 1 -depth ! -name 'assembly.fasta' ! -name 'flye.log' -delete
mv "$OUT_DIR/assembly.fasta" "$OUT_DIR/conda_assembly.fasta"
mv "$OUT_DIR/flye.log" "$OUT_DIR/conda_flye.log"

# deactivate
conda deactivate
