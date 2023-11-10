#!/usr/bin/env bash
#SBATCH -J filtlong
#SBATCH --partition=medium
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# porechop reads = $1

fileshort=$(basename $1 | sed s/".fastq.gz"//g)

filtlong --min_mean_q 93.7 $1 | gzip > "$fileshort"_q12.fastq.gz

# percentage = 1 - (10^-(Q/10))
