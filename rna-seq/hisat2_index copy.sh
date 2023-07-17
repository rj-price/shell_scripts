#!/usr/bin/env bash
#SBATCH -J hisat2
#SBATCH --partition=short
#SBATCH --mem=2G
#SBATCH --cpus-per-task=2

# genome = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $1 | sed s/".fasta"//g)

hisat2-build $1 /mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/annotation/genome_index/$fileshort

