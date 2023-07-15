#!/usr/bin/env bash
#SBATCH -J GSAlign 
#SBATCH --partition=long
#SBATCH --mem=12G
#SBATCH --cpus-per-task=12

#INPUT:
# Genome1=$1
# Genome2=$2
# Prefix=$3
# Outdir=$4 

#OUTPUT:
# Check slurm out file for quick stats on variants detected and genome similiary ANI%, outfiles are variants and corresponding data 

Genome1=$1
Genome2=$2
Prefix=$3
Outdir=$4

GSAlign -r $Genome1 -q $Genome2 -o $Outdir/$Prefix -dp
