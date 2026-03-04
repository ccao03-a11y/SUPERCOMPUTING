a5
# Chunyang Cao, 03/04/2026, Assignment_05

## Descriptions

### Setup assignment_05/ directory

cd assignments/assignment_05

mkdir scripts

mkdir log

mkdir data

cd data

mkdir raw

mkdir trimmed

### Write a script in scripts/ to download and prepare fastq data

cd ..

cd scripts/

nano 01_download_data.sh

#!/bin/bash

set -ueo pipefail

### Download directory

cd ~/SUPERCOMPUTING/assignments/assignment_05/data/raw

wget https://gzahn.github.io/data/fastq_examples.tar

tar -xvf fastq_examples.tar

rm fastq_examples.tar

chmod +x 01_download_data.sh 

export PATH=$PATH:/sciclone/home/ccao03/SUPERCOMPUTING/assignments/assignment_05/scripts

./01_download_data.sh

### Install fastp tool in programs/

cd ~/programs

wget http://opengene.org/fastp/fastp

chmod a+x ./fastp

### Path has already been added to .bashrc

### Get the version of fastp

fastp -v

### fastp version

fastp 1.1.0

### Write a script in scripts/ to run fastp

cd SUPERCOMPUTING/assignments/assignment_05/scripts

nano 02_run_fastp.sh

chmod +x 02_run_fastp.sh

#!/bin/bash

FWD_IN=$1

REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}

REV_OUT=${REV_IN/.fastq.gz/.trimmed.fastq.gz}

fastp --in1 $FWD_IN --in2 $REV_IN --out1 ${FWD_OUT/raw/trimmed} --out2 ${REV_OUT/raw/trimmed} --json /dev/null --html log/$(basename "$FWD_IN").html --trim_front1 8 --trim_front2 8 --trim_tail1 20 --trim_tail2 20 --n_base_limit 0 --length_required 100 --average_qual 20

### Write pipeline.sh in assignments_05/

cd ..

### Test

./scripts/02_run_fastp.sh ./data/raw/6083_001_S1_R1_001.subset.fastq.gz

nano pipeline.sh

#!/bin/bash

set -euo pipefail

MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_05

SCRIPTS_DIR=${MAIN_DIR}/scripts

DATA_DIR=${MAIN_DIR}/data/raw

echo "downloading data files"

${SCRIPTS_DIR}/01_download_data.sh

echo "running fastp"

### Run 02_run_fastp.sh on every R1 files in data/raw

for FWD in ${DATA_DIR}/*_R1_*;do ${SCRIPTS_DIR}/02_run_fastp.sh $FWD; done

### Remove all data files

cd ~/SUPERCOMPUTING/assignments/assignment_05/data/raw

rm *

### Run pipeline.sh

cd ~/SUPERCOMPUTING/assignments/assignment_05

./pipeline.sh

## How to run the pipeline

Add the directory where pipeline.sh at to your $PATH environment variable. Type ./pipeline.sh to run it. It will first download all the data from https://gzahn.github.io/data/fastq_examples.tar to data/raw, and it will iterate through all R1 files and run fastp on each file. The script automatically identifies the corresponding R2 file. It will remove first 8 bases and last 20 bases from fwd (R1) and rev (R2) files. It will also discards any reads with “N”, reads shorter than 100nt, and reads <20 avg quality. Then, the processed files will be stored in data/trimmed along with html reports in log/.

## Reflection

I had some trouble figuring out json and html commands because I’m not familiar with their function. I’ve learned how to write multiple paramters in a line, like what I’ve done for fastp. Separating the scripts makes it easier to call each function individually. You can also call them comprehensively using pipeline.sh, which makes the usage of the scripts more flexible. The shortcoming is it would be troublesome to modify multiple scripts especially when they are in different directories.
