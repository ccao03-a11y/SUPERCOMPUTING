# Chunyang Cao, 03/26/2026, Assignment_07

## Descriptions

### Setup assignment_07/ directory

cd SUPERCOMPUTING/assignments/assignment_07

mkdir data output scripts

cd data

mkdir clean dog_reference raw

### Search string: (Shotgun[All Fields] AND ("metagenome"[Organism] OR ("metagenome"[Organism] OR metagenome[All Fields])) AND data[All Fields]) AND "platform illumina"[Properties]. After sending to run selector, I chose libraryselection and random.

### Write a script to download data in data/raw

cd scripts

nano 01_download_data.sh 

#!/bin/bash

set -euo pipefail

BASE_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07

DATA_DIR=${BASE_DIR}/data

OUT_DIR=${DATA_DIR}/raw

DOG_DIR=${DATA_DIR}/dog_reference

mkdir -p $OUT_DIR

mkdir -p $DOG_DIR

for i in $(cut -d ',' -f1 ${DATA_DIR}/SraRunTable.csv | tail -n +2); do fastq-dump --gzip --split-3 -O "${OUT_DIR}" "$i"; done

> download data to data/raw using fasterq-dump, and use gzip to turn each data into .gz

datasets download genome taxon "Canis familiaris" --reference --filename ${DOG_DIR}/dog_reference_genome.zip

> use the dataset command to download the reference genome for Canis familiaris to data/dog_reference

unzip ${DOG_DIR}/dog_reference_genome.zip

> unzip the zip file

mv ${DOG_DIR}/ncbi_dataset/data/GCF_*/GCF_*.fna ${DOG_DIR}/dog_reference_genome.fna

> move the fna file to dog_reference directory and rename it

rm -r ncbi_dataset README.md dog_reference_genome.zip md5sum.txt

> clean up

chmod +x 01_download_data.sh

export PATH=$PATH:/sciclone/home/ccao03/SUPERCOMPUTING/assignments/assignment_07/scripts

### Clean up raw reads

nano 02_clean_reads.sh

#!/bin/bash

set -euo pipefail

DATA_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07/data

RAW_DIR=${DATA_DIR}/raw

CLEAN_DIR=${DATA_DIR}/clean

mkdir -p $CLEAN_DIR

for i in $(cut -d ',' -f1 ${DATA_DIR}/SraRunTable.csv | tail -n +2) 

do

FWD_IN=“${RAW_DIR}/${i}_1.fastq.gz”

REV_IN=“${RAW_DIR}/${i}_2.fastq.gz”

FWD_OUT=“${CLEAN_DIR}/${i}_1.trimmed.fastq.gz”

REV_OUT=“${CLEAN_DIR}/${i}_2.trimmed.fastq.gz”

fastp -i $FWD_IN -I $REV_IN -o $FWD_OUT -O $REV_OUT

done

> use fastp to filter the data in data/raw and output them into data/clean

chmod +x 02_clean_reads.sh

### Map clean reads to dog genome and extract reads that matched dog genome

nano 03_map_reads.sh

#!/bin/bash

set -euo pipefail

module load samtools/gcc-11.4.1/1.22.1

DATA_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07/data

OUT_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_07/output

for i in $(cut -d ',' -f1 "${DATA_DIR}/SraRunTable.csv" | tail -n +2) 

do

FWD_IN=${DATA_DIR}/clean/{i}_1.trimmed.fastq.gz

REV_IN=${DATA_DIR}/clean/{i}_2.trimmed.fastq.gz

bbmap.sh -Xmx16g ref=${DATA_DIR}/dog_reference_genome.fna in1=$FWD_IN in2=$REV_IN out=$OUT_DIR/${i}.sam minid=0.95

> use bbmap to map trimmed data in data/clean with against the dog reference genome in data/dog_reference. Save the sam files in output directory. I requested 32GB and 10 hours from the bora server.

samtools view -h -F 4 ${OUT_DIR}/${i}.sam > ${OUT_DIR}/${i}_dog-matches.sam

> use samtools to remove the data that are not matched. Save the matched sam file in output directory

rm "${OUT_DIR}/${i}.sam"

> remove sam file to clean up the space

done

chmod +x 03_map_reads.sh

## Reflection

I was struggling to understand how the third pipeline works. When I tried to run a small test on the scripts, it shows failed to call external services. I don’t know why it happened, so I just submitted the slurm job without testing. It failed and shows no such fastq data. I asked AI for help, Gemini said it’s because it’s running out of space and suggested me to zip the data while downloading and also remove the sam file everytime after using samtools. It turns out I did not request enough run time. It spent 10 hours but still not finished downloading data, so the job eventually failed. Perhaps there’s something wrong with the data I chose. I’ve learned more about how to use bbmap and samtools.
