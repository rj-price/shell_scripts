#!/usr/bin/env bash
#SBATCH -J porechop
#SBATCH --partition=long
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16

# reads_dir = $1
# output_dir = $2

porechop \
    -i $1 \
    -b $2 \
    -t 16
