#!/bin/bash

set -euo pipefail

BASE_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07
DATA_DIR=${BASE_DIR}/data
OUT_DIR=${DATA_DIR}/raw
DOG_DIR=${DATA_DIR}/dog_reference
mkdir -p $OUT_DIR
mkdir -p $DOG_DIR

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2); do fastq-dump --gzip --split-3 -O "${OUT_DIR}" "$i"; done

datasets download genome taxon "Canis familiaris" --reference --filename "${DOG_DIR}/dog_reference_genome.zip"
unzip "${DOG_DIR}/dog_reference_genome.zip"
mv "${DOG_DIR}/ncbi_dataset/data/GCF_*/GCF_*.fna" "${DOG_DIR}/dog_reference_genome.fna"
rm -r ncbi_dataset README.md dog_reference_genome.zip md5sum.txt
