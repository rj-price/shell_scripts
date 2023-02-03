#!/usr/bin/env bash
#SBATCH -J nanoplot
#SBATCH --partition=long
#SBATCH --mem=4G
#SBATCH --cpus-per-task=2

# fastq = $1
# output_dir = $2

NanoPlot -t 2 --fastq $1 -o $2
