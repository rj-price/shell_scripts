#!/usr/bin/env bash
#SBATCH -J SPAdes
#SBATCH --partition=long
#SBATCH --mem=14G
#SBATCH --cpus-per-task=8

# F_reads = $1
# R_reads = $2
# out_dir = $3

spades.py -m 250 -k 21,33,55,77,99,127 --careful \
    --pe1-1 $1 \
    --pe1-2 $2 \
    -o $3
