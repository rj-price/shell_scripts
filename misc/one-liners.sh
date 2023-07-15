# Bash one liners and other useful commands

## Default interactive session
srun --pty bash
srsh

## Running interactive session with defined compute
srun --partition long --mem 32G --cpus-per-task 8 --pty bash

## This recursively traverses files and counts extensions that match:
$ find . -type f | sed -e 's/.*\.//' | sort | uniq -c | sort -n | grep -Ei '(tiff|bmp|jpeg|jpg|png|gif)$'

## Count of all the files in the current directory and subdirectories
find . -type f | wc -l

## Uncompress tar file and keep original
tar -xvkf {file}.tar

## Counting number of sequences in a fasta file:
grep -c "^>"

## Check size of directory
du -hcs <directory>

## This finds and deletes the empty files in the current directory without going into sub-directories
find . -maxdepth 1 -type f -size 0 -delete

## Rename files based on list of file names
awk -F',' 'system("mv " $1 " " $2)' names.csv

## Count bases of each entry in fasta file
bioawk -c fastx '{ print $name, length($seq) }' < sequences.fasta

## Count bases of each entry in fasta file and sort by nucleotide size
bioawk -c fastx '{ print $name, length($seq) }' < sequences.fasta | sort -k2 -n

## Rename sequences in fasta file
awk '/^>/{print ">contig" ++i; next}{print}' < file.fasta

## Remove entries from fasta file
cat input.fasta | awk '/>fasta_entry/ {getline; while(!/>/) {getline}} 1' > output.fasta

## Sort fasta file by length and rename contigs
seqkit sort --by-length --reverse in.fasta | seqkit replace --pattern '.+' --replacement 'contig_{nr}' > out.fasta

## Remove duplicates in fasta file based on ID
awk '/^>/{f=!d[$1];d[$1]=1}f' in.fa > out.fa

## Convert multiline fasta to single line fasta
awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' multiline.fasta > singleline.fasta
