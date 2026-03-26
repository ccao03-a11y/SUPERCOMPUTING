#!/bin/bash

set -euo pipefail
module load samtools/gcc-11.4.1/1.22.1

DATA_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07/data
OUT_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07/output

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2) 
do
FWD_IN="${DATA_DIR}/clean/{i}_1.trimmed.fastq.gz"
REV_IN="${DATA_DIR}/clean/{i}_2.trimmed.fastq.gz"

bbmap.sh -Xmx16g ref="${DATA_DIR}/dog_reference_genome.fna" in1="${FWD_IN}" in2="${REV_IN}" out="$OUT_DIR/${i}".sam minid=0.95

samtools view -h -F 4 "${OUT_DIR}/${i}.sam" > "${OUT_DIR}/${i}_dog-matches.sam"
done
