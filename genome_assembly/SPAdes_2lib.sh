#!/usr/bin/env bash
#SBATCH -J SPAdes
#SBATCH --partition=himem
#SBATCH --mem=250G
#SBATCH --cpus-per-task=16

# F_reads (lib1) = $1
# R_reads (lib1) = $2
# F_reads (lib2) = $3
# R_reads (lib2) = $4
# out_dir = $5

spades.py -m 250 -k 21,33,55,77,99,127 --careful \
    --pe1-1 $1 \
    --pe1-2 $2 \
    --pe1-1 $3 \
    --pe1-2 $4 \
    -o $5
