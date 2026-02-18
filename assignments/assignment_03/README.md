# Chunyang Cao, 02/18/2026, Assignment_03

## Commands

cd SUPERCOMPUTING/assignments/assignment_03

touch README.md

mkdir data

cd data

wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz

gunzip GCF_000001735.4_TAIR10.1_genomic.fna.gz

ll

### 1

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l

### 2

grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | tr -d '\n' |  wc -c

### 3

wc -l GCF_000001735.4_TAIR10.1_genomic.fna

### 4

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "mitochondrion" | wc -l

### 5

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "chromosome" | wc -l

### 6

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna

sed -n '2p' GCF_000001735.4_TAIR10.1_genomic.fna | wc -c

sed -n '4p' GCF_000001735.4_TAIR10.1_genomic.fna | wc -c

sed -n '6p' GCF_000001735.4_TAIR10.1_genomic.fna | wc -c

### 7

sed -n '10p' GCF_000001735.4_TAIR10.1_genomic.fna | wc -c

### 8

grep "AAAAAAAAAAAAAAAA" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l

### 9

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | sort

### 10

grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna > headers.txt

grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna > seqs.txt

paste headers.txt seqs.txt

## Reflection

Approaches for task 3. For the first one, I used grep "^>" to find the headers which start with > and wc -l to count the total lines of sequences. For the second one, I used grep -v "^>" to exclude the headers. Here, I used tr -d '\n' to delete new lines and wc -c to count the total number of nucleotides. I used wc -l for the third question. For the fourth and fifth questions, I first used grep "^>" to get the headers and grep "mitochondrion" or "chromosome" to find header lines containing the word. For the sixth question, since we know there is only one sequence after each head line, I first took a look at all the header lines to examine the line numbers of the first 3 chromosome sequences. Then, I applied sed to get each of the first 3 chromosome sequences and count the number of nucleotides separately. I applied the same approach for chromosome 5. For the eighth one, I used grep "AAAAAAAAAAAAAAAA" and wc -l to find the number of sequences that contain "AAAAAAAAAAAAAAAA”. To sort the sequences alphabetically, I first selected all the head lines and used sort. For the last one, I decided to create two new files. One is headers.txt using grep "^>”, and the other one is seqs.txt using grep -v "^>”. The next step is using paste to paste them side by side. I’ve learned what nucleotides are and the use of -v, -d, and sed.

I stuck at the sixth question for a long time. I originally thought to create a new file that contains the first 3 chromosomes and do the word count. However, I did not know how to include the line after the header, so I searched online and found sed. Then, I realized I could simply count the number of words in each line without creating a new file. 

These kinds of skills are essential because in computational work, we could not open the file using Excel or some other tools and data might be very large, we could quickly locate the information we want. Moreover, similar commands can be used on different data without manual manipulation.
