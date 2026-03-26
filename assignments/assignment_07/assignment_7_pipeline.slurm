#!/bin/bash
#SBATCH --job-name=assignment_7
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=10:00:00
#SBATCH --mem=32G
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --mail-user=ccao03@wm.edu
#SBATCH -o /sciclone/home/ccao03/SUPERCOMPUTING/assignments/assignment_07/output/assignment_7.out
#SBATCH -e /sciclone/home/ccao03/SUPERCOMPUTING/assignments/assignment_07/output/assignment_7.err

set -euo pipefail

export PATH=$PATH:/sciclone/home/ccao03/programs/sratoolkit.3.4.0-ubuntu64/bin

./scripts/01_download_data.sh
./scripts/02_clean_reads.sh
./scripts/03_map_reads.sh

