#!/usr/bin/env bash
#SBATCH -J unicycler
#SBATCH --partition=himem
#SBATCH --mem=150G
#SBATCH --cpus-per-task=8

# Reads = $1
# Output = $2

unicycler -l $1 -o $2


