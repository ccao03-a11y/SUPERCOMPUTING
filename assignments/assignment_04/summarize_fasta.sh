#!/bin/bash
set -ueo pipefail

file=$1
NumSeqs=$(seqtk size $1 | cut -f 1)
echo "Total number of sequences: $NumSeqs"
NumNucleo=$(seqtk size $1 | cut -f 2)
echo "Total number of nucleotides: $NumNucleo"
echo "Table of sequence names and lengths:"
seqtk comp $1 | cut -f 1,2
