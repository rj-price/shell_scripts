#!/usr/bin/env bash
#SBATCH -J filtlong
#SBATCH --partition=long
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16

# porechop reads = $1
# output prefix = $2

filtlong --min_length 10000 --keep_percent 95 $1 | gzip > $2_10kb.fastq.gz
