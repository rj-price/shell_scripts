#!/usr/bin/env bash
#SBATCH -J porechop
#SBATCH --partition=long
#SBATCH --mem=8G
#SBATCH --cpus-per-task=4

# reads_dir = $1
# output = $2

porechop \
    -i $1 \
    -o $2
