#!/usr/bin/env bash
#SBATCH -J fast5
#SBATCH --partition=long
#SBATCH --mem=4G
#SBATCH --cpus-per-task=2

# sequencing directory = $1
# output directory = $2

single_to_multi_fast5 --recursive -t 2 -i $1 -s $2
