#!/usr/bin/env bash
#SBATCH -J wtdbg2
#SBATCH --partition=long
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16

# reads file = $1
# genome size = $2

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
mkdir $fileshort
cd $fileshort
wtdbg2 -x ont -g $2 -i $1 -t 16 -fo "$fileshort"_wtdbg
wtpoa-cns -t 16 -i "$fileshort"_wtdbg.ctg.lay.gz -fo "$fileshort"_wtdbg.ctg.fa
cp "$fileshort"_wtdbg.ctg.fa ../"$fileshort"_wtdbg.fasta
