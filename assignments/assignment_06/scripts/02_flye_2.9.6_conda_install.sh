#!/bin/bash

set -euo pipefail

# set up
module load miniforge3

source /sciclone/apps/miniforge3-24.9.2-0/etc/profile.d/conda.sh

# build conda environment
mamba create -y -n flye-env flye=2.9.6 -c bioconda

# activate
conda activate flye-env

# export yml file
conda env export --no-builds > flye-env.yml

# test
flye -v

# deactivate
conda deactivate
