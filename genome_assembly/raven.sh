#!/usr/bin/env bash
#SBATCH -J raven
#SBATCH --partition=long
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16

# reads file = $1
# output prefix = $2

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
mkdir $fileshort
cd $fileshort
raven -t 16 $1 > "$fileshort"_raven.fasta
rm raven.cereal
mv "$fileshort"_raven.fasta ..
cd ..
rm -r $fileshort

