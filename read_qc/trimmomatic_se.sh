#!/usr/bin/env bash
#SBATCH -J trimmomatic
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# Reads = $1 

ln -s $1

file1=$(basename $1)
fileshort=$(basename $1 | sed s/_1.fq.gz//g)
trimmomatic SE -threads 8 -phred33 $file "$fileshort".trimmed.fq.gz ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 HEADCROP:12 MINLEN:80