#!/bin/bash

set -euo pipefail

cd ./data
wget https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1
mv *fastq.gz* SRR33939694.fastq.gz
