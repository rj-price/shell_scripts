#!/usr/bin/env bash
#SBATCH -J salmon
#SBATCH --partition=medium
#SBATCH --mem=2G
#SBATCH --cpus-per-task=4

# transcriptome_cds = $1

fileshort=$(basename $1 | sed s/".fasta"//g)

salmon index -t $1 -i "$fileshort"_index --keepDuplicates -k 27
