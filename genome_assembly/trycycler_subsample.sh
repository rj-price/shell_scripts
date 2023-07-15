#!/usr/bin/env bash
#SBATCH -J trycycler
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# reads = $1
# count = $2

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
trycycler subsample --count $2 --genome_size 8m --threads 8 --reads $1 --out_dir $fileshort

