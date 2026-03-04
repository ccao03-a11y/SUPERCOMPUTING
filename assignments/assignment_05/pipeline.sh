#!/bin/bash
set -euo pipefail

MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_05
SCRIPTS_DIR=${MAIN_DIR}/scripts
DATA_DIR=${MAIN_DIR}/data/raw

echo "downloading data files"
${SCRIPTS_DIR}/01_download_data.sh

echo "running fastp"
for FWD in ${DATA_DIR}/*_R1_*;do ${SCRIPTS_DIR}/02_run_fastp.sh $FWD; done
