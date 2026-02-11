Chunyang Cao, 02/11/2026, Assignment_02

Descriptions of the tasks
Task 1: Set up workspace and create data folder
Task 2: Download files from NCBI via FTP
Task 3: File transfer using FileZilla and permission change
Task 4: Verify file integrity with md5sum
Task 5: Create bash aliases
Task 6: Document everything in README.md

Directory structure
data
-GCF_000005845.2_ASM584v2_genomic.fna.gz
-GCF_000005845.2_ASM584v2_genomic.gff.gz
README.md

All commands used
Local:
ftp ftp.ncbi.nlm.nih.gov
bye
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz
md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz
md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz
nano README.md
HPC:
cd SUPERCOMPUTING/assignments/assignment_02
mkdir data
git commit -m"Add Assignment 2 data
git push
md5sum GCF_000005845.2_ASM584v2_genomic.fna.gz
md5sum GCF_000005845.2_ASM584v2_genomic.gff.gz
nano README.md
nano .bashrc
source ~/.bashrc

MD5 hashes
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz
2238238dd39e11329547d26ab138be41  GCF_000005845.2_ASM584v2_genomic.gff.gz
matched

Reflection
I first tried using cd to navigate to the path in NCBI and it showed connection refused. Then I typed passive and tried again, but it said no transfer time out. Hence, I directly used wget and the link to the files. There was also error showed when running source ~/.bashrc, but the new alias were successfully enabled.

Descriptions for alias
alias u: Go to the parent directory. Clear the screen. Show the current directory and the content of current directory.
alias d: Go to the last directory you were at. Clear the screen. Show the current directory and the content of current directory.
alias ll: Show the content of current directory.
