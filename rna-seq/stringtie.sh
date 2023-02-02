#!/usr/bin/env bash
#SBATCH -J stringtie
#SBATCH --partition=long
#SBATCH --mem=6G
#SBATCH --cpus-per-task=4

# sorted bam = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $1 | sed s/".sorted.bam"//g)

stringtie -o "$fileshort".gtf $1

