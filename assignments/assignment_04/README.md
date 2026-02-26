# Chunyang Cao, 02/25/2026, Assignment_04

## Descriptions

### Download and unpack the tarball file in programs directory

cd programs

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_arm64.tar.gz

tar -xzvf gh_2.74.2_linux_arm64.tar.gz

rm gh_2.74.2_linux_arm64.tar.gz

### Build install script in programs directory

nano install_gh.sh

### !/bin/bash

set -ueo pipefail

### download

wget $1

### unzip the file using basename

tar $(basename $1)

### remove the unzipped file
rm $(basename $1)

### Make the file executable

chmod +x install_gh.sh

### Add the location to $PATH

export PATH=$PATH:/sciclone/home/ccao03/programs

### Create seqtk install script in programs directory

nano install_seqtk.sh

### Download seqtk

git clone https://github.com/lh3/seqtk.git;

cd seqtk; make

### add the seqtk directory to $PATH, and echo to the end of ~/.bashrc file

echo "export PATH=$PATH:/sciclone/home/ccao03/programs/seqtk” >> ~/.bashrc

### Make the file executable

chmod +x install_seqtk.sh

### Create summarize_fasta.sh script in assignment_04 directory

nano summarize_fasta.sh

### !/bin/bash

set -ueo pipefail

### store the filename in a variable

file=$1

### store the first output of seqtk size as NumSeqs and echo the explaination
NumSeqs=$(seqtk size $1 | cut -f 1)

echo "Total number of sequences: $NumSeqs"

### store the second output of seqtk size as NumNucleo and echo the explaination

NumNucleo=$(seqtk size $1 | cut -f 2)

echo "Total number of nucleotides: $NumNucleo"

### echo the table explaination and output the first two output of seqtk comp

echo "Table of sequence names and lengths:"

seqtk comp $1 | cut -f 1,2 

### Make the file executable

chmod +x summarize_fasta.sh

### Create data directory

mkdir data

cd data

### Download and unzip fasta files

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_rna_from_genomic.fna.gz

wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna.gz

gunzip GCF_000001405.40_GRCh38.p14_cds_from_genomic.fna.gz

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz

gunzip GCF_000005845.2_ASM584v2_rna_from_genomic.fna.gz

### Run summarize_fasta.sh in a loop

cd . .

for file in data/*.fna

> do

> ./summarize_fasta.sh $file

> done

## Reflection

The challenge I've encountered is in task 2. I was wondering how to get the name of file automatically. Then, I found basename to extract the filename with extension. I've learned the use of basename and enhanced the script writing skill. $PATH is to tell the system where the executable files are. We can run files in $PATH directly, otherwise we have to use ./filename to run the file.
