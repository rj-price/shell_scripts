#!/usr/bin/env bash
#SBATCH -J racon
#SBATCH --partition=long
#SBATCH --mem=100G
#SBATCH --cpus-per-task=16

# iterations = $1
# reads = $2
# assembly = $3

fileshort=$(basename $3 | sed s/".fasta"//g)
/mnt/shared/scratch/jnprice/apps/raconnn/raconnn $1 $2 $3 > "$fileshort"_racon.fasta

