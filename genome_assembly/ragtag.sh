#!/usr/bin/env bash
#SBATCH -J ragtag
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=16

# ref assembly = $1
# query assembly = $2

fileshort=$(basename $2 | sed s/".fasta"//g)

ragtag.py scaffold -t 16 -o ./$fileshort $1 $2 
