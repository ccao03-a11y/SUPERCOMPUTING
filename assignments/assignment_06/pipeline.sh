#!/bin/bash

set -euo pipefail

MAIN_DIR=${HOME}/SUPERCOMPUTING/assignments/assignment_06
SCRIPTS_DIR=${MAIN_DIR}/scripts
CONDA_DIR=${MAIN_DIR}/assemblies/assembly_conda
MODULE_DIR=${MAIN_DIR}/assemblies/assembly_module
LOCAL_DIR=${MAIN_DIR}/assemblies/assembly_local

${SCRIPTS_DIR}/01_download_data.sh
${SCRIPTS_DIR}/02_flye_2.9.6_conda_install.sh
${SCRIPTS_DIR}/02_flye_2.9.6_manual_build.sh
${SCRIPTS_DIR}/03_run_flye_conda.sh
${SCRIPTS_DIR}/03_run_flye_local.sh
${SCRIPTS_DIR}/03_run_flye_module.sh

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
