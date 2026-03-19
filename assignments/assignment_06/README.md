# Chunyang Cao, 03/18/2026, Assignment_06

## Descriptions

### Setup assignment_06/ directory

cd SUPERCOMPUTING/assignments/assignment_06

mkdir assemblies

mkdir data

mkdir scripts

cd assemblies

mkdir assembly_conda

mkdir assembly_local

mkdir assembly_module

### In scripts/, create 01_download_data.sh to download data
cd scripts

nano 01_download_data.sh

#!/bin/bash

set -euo pipefail

cd ./data

wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1

mv *fastq.gz* SRR33939694.fastq.gz

> Since the data was named as 'SRR33939694.fastq.gz?download=1’, I have to change the name

chmod +x 01_download_data.sh

### Create 02_flye_2.9.6_manual_build.sh in scripts/

nano 02_flye_2.9.6_manual_build.sh

#!/bin/bash

set -euo pipefail

cd ~/programs/

git clone https://github.com/fenderglass/Flye

cd Flye

make

chmod +x 02_flye_2.9.6_manual_build.sh

export PATH=$PATH:/sciclone/home/ccao03/programs/Flye/bin

### Create 02_flye_2.9.6_conda_install.sh in scripts/

nano 02_flye_2.9.6_conda_install.sh

#!/bin/bash

set -euo pipefail

### set up

module load miniforge3

source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh

### build conda environment

mamba create -y -n flye-env flye=2.9.6 -c bioconda

### activate

conda activate flye-env

### export yml file

conda env export --no-builds > flye-env.yml

### test

flye -v

### deactivate

conda deactivate

chmod +x 02_flye_2.9.6_conda_install.sh

### Create 03_run_flye_conda.sh in scripts/

nano 03_run_flye_conda.sh

#!/bin/bash

### activate environment

module load miniforge3

source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh

conda activate flye-env

### create output directory

DATA_DIR="./data/SRR33939694.fastq.gz"

OUT_DIR="./assemblies/assembly_conda"

mkdir -p "$OUT_DIR"

### remove everything in the output directory

rm -rf "$OUT_DIR"/*

### process data

flye --nano-hq "$DATA_DIR" --out-dir "$OUT_DIR" --genome-size 50k --meta --threads 6

### clean up

find "$OUT_DIR" -mindepth 1 -depth ! -name 'assembly.fasta' ! -name 'flye.log' -delete

mv "$OUT_DIR/assembly.fasta" "$OUT_DIR/conda_assembly.fasta"

mv "$OUT_DIR/flye.log" "$OUT_DIR/conda_flye.log"

### deactivate

conda deactivate

### Create 03_run_flye_conda.sh in scripts/

chmod +x 03_run_flye_conda.sh

nano 03_run_flye_module.sh

#!/bin/bash

module load Flye/gcc-11.4.1/2.9.6

### create output directory

DATA_DIR="./data/SRR33939694.fastq.gz"

OUT_DIR="./assemblies/assembly_module"

mkdir -p "$OUT_DIR"

### remove everything in the output directory

rm -rf "$OUT_DIR"/*

### process data

flye --nano-hq "$DATA_DIR" --out-dir "$OUT_DIR" --genome-size 50k --meta --threads 6

### clean up

find "$OUT_DIR" -mindepth 1 -depth ! -name 'assembly.fasta' ! -name 'flye.log' -delete

mv "$OUT_DIR/assembly.fasta" "$OUT_DIR/module_assembly.fasta"

mv "$OUT_DIR/flye.log" "$OUT_DIR/module_flye.log"

### deactivate

module unload Flye/gcc-11.4.1/2.9.6

chmod +x 03_run_flye_module.sh

nano 03_run_flye_local.sh

#!/bin/bash

export PATH=$PATH:/sciclone/home/ccao03/programs/Flye/bin

### create output directory

DATA_DIR="./data/SRR33939694.fastq.gz"

OUT_DIR="./assemblies/assembly_local"

mkdir -p "$OUT_DIR"

### remove everything in the output directory

rm -rf "$OUT_DIR"/*

### process data

flye --nano-hq "$DATA_DIR" --out-dir "$OUT_DIR" --genome-size 50k --meta --threads 6

### clean up

find "$OUT_DIR" -mindepth 1 -depth ! -name 'assembly.fasta' ! -name 'flye.log' -delete

mv "$OUT_DIR/assembly.fasta" "$OUT_DIR/local_assembly.fasta"

mv "$OUT_DIR/flye.log" "$OUT_DIR/local_flye.log"

chmod +x 03_run_flye_local.sh

### Output the last 10 lines of each file in assemblies

tail -n 10 conda_assembly.fasta

tail -n 10 conda_flye.log

tail -n 10 module_assembly.fasta

tail -n 10 module_flye.log

tail -n 10 local_assembly.fasta

tail -n 10 local_flye.log

> Results are the same

### Build pipeline.sh under assignments_06/

nano pipeline.sh

#!/bin/bash

set -euo pipefail

MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_06

SCRIPTS_DIR=${MAIN_DIR}/scripts

CONDA_DIR=${MAIN_DIR}/assemblies/assembly_conda

MODULE_DIR=${MAIN_DIR}/assemblies/assembly_module

LOCAL_DIR=${MAIN_DIR}/assemblies/assembly_local

### Run each script

${SCRIPTS_DIR}/01_download_data.sh

${SCRIPTS_DIR}/02_flye_2.9.6_conda_install.sh

${SCRIPTS_DIR}/02_flye_2.9.6_manual_build.sh

${SCRIPTS_DIR}/03_run_flye_conda.sh

${SCRIPTS_DIR}/03_run_flye_local.sh

${SCRIPTS_DIR}/03_run_flye_module.sh

### Output the last 10 lines

echo "Last 10 lines of conda_assembly.fasta: "

tail -n 10 ${CONDA_DIR}/conda_assembly.fasta

echo "Last 10 lines of conda_flye.log: "

tail -n 10 ${CONDA_DIR}/conda_flye.log

echo "Last 10 lines of module_assembly.fasta: "

tail -n 10 ${MODULE_DIR}/module_assembly.fasta

echo "Last 10 lines of module_flye.log: "

tail -n 10 ${MODULE_DIR}/module_flye.log

echo "Last 10 lines of local_assembly.fasta: "

tail -n 10 ${LOCAL_DIR}/local_assembly.fasta

echo "Last 10 lines of local_flye.log: "

tail -n 10 ${LOCAL_DIR}/local_flye.log

## pipeline

Under the assignment_06 directory, type pipeline.sh to run it. It will first download the data to the data directory. Then, it will install Flye v2.9.5 in the programs directory and build a conda environment for it called flye-env. Next, it will use 3 ways, conda environment, local, and module environment, to run Flye on the data. During this process, it will create three subfolders under the assemblies directory, each represents a method. In each subfolder, only two files will be preserved, assembly.fasta and flye.log. Finally, it will output the last 10 lines of each file in those subfolders under the assemblies directory.

## Reflections

The challenge I have encountered is to discover the usage of Flye. I have very limited knowleage about biology, so I was very confused about how to get the results from data and I had to ask ChatGPT for explaination. I have learned how to use find method and some basic usage of Flye. I prefer using local build method because it’s much more easier, but I will use conda for the next assignment because it makes me feel safe.
