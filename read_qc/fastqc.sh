#!/usr/bin/env bash
#SBATCH -J fastqc
#SBATCH --partition=long
#SBATCH --mem=1G
#SBATCH --cpus-per-task=2

# reads = $1

mkdir fastqc_trimmed
fastqc $1 -t 2 -o fastqc_trimmed
