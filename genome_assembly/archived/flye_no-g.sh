#!/usr/bin/env bash
#SBATCH -J flye
#SBATCH --partition=long
#SBATCH --mem=150G
#SBATCH --cpus-per-task=16

# reads file = $1

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
mkdir $fileshort
flye --nano-raw $1 -o $fileshort -t 16
mv $fileshort/assembly.fasta ./"$fileshort"_flye_no-g.fasta
