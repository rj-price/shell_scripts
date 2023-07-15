#!/usr/bin/env bash
#SBATCH -J ragoo
#SBATCH --partition=long
#SBATCH --mem=32G
#SBATCH --cpus-per-task=8

# Reads = $1
# Assembly = $2
# Reference = $3

python /home/pricej/programs/RaGOO/ragoo.py -R $1 -T corr -t 8 $2 $3
