#!/usr/bin/env bash
#SBATCH -J porechop
#SBATCH --partition=long
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4

# reads_dir = $1
# output_dir = $2

porechop \
    -i $1 \
    -b $2 \
    -t 4
