#!/usr/bin/env bash
#SBATCH -J trycycler
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# assemblies_dir = $1
# reads = $2

fileshort=$(basename $2 | sed s/".fastq.gz"//g)
trycycler cluster --threads 8 --assemblies $1/*.fasta --reads $2 --out_dir $fileshort/"$fileshort"_clusters

