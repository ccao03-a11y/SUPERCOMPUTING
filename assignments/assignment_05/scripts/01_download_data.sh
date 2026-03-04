#!/bin/bash
set -ueo pipefail

cd ~/SUPERCOMPUTING/assignments/assignment_05/data/raw
wget https://gzahn.github.io/data/fastq_examples.tar
tar -xvf fastq_examples.tar
rm fastq_examples.tar
