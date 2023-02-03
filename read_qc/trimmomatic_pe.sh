#!/usr/bin/env bash
#SBATCH -J trimmomatic
#SBATCH --partition=long
#SBATCH --mem=1G
#SBATCH --cpus-per-task=8

# F reads = $1 
# R reads = $2

ln -s $1
ln -s $2

file1=$(basename $1)
file2=$(basename $2)
fileshort=$(basename $1 | sed s/_1.*fq.gz//g)

trimmomatic PE -threads 16 -phred33 $file1 $file2 "$fileshort"_F_paired.fastq.gz "$fileshort"_F_unpaired.fastq.gz "$fileshort"_R_paired.fastq.gz "$fileshort"_R_unpaired.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 HEADCROP:10 MINLEN:140

#trimmomatic PE -threads 16 -phred33 $file1 $file2 "$fileshort"_F_paired.fastq.gz "$fileshort"_F_unpaired.fastq.gz "$fileshort"_R_paired.fastq.gz "$fileshort"_R_unpaired.fastq.gz HEADCROP:12 MINLEN:100
