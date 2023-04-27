#!/usr/bin/env bash
#SBATCH -J prokka
#SBATCH --partition=long
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8

# assembly = $1

fileshort=$(basename $1 | sed s/".fasta"//g)

prokka --outdir $fileshort --prefix $fileshort $1
