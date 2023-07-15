#!/usr/bin/env bash
#SBATCH -J trycycler
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# clusters_dir = $1
# reads = $2

fileshort=$(basename $2 | sed s/".fastq.gz"//g)

for folder in $1/cluster*;
    do trycycler reconcile --threads 8 --reads $2 --cluster_dir $folder
    done
