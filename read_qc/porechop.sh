#!/usr/bin/env bash
#SBATCH -J porechop
#SBATCH --partition=medium
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4

# reads_dir = $1
# output = $2

porechop \
    -i $1 \
    -o $2
