#!/usr/bin/env bash
#SBATCH -J porechop
#SBATCH --partition=long
#SBATCH --mem=48G
#SBATCH --cpus-per-task=16

# reads_dir = $1
# output = $2

porechop \
    -i $1 \
    -o $2
