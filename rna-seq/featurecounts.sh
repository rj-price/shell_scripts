#!/usr/bin/env bash
#SBATCH -J featurecounts
#SBATCH --partition=long
#SBATCH --mem=500M
#SBATCH --cpus-per-task=4

# sorted bam = $1
# transcriptome = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $1 | sed s/".sorted.bam"//g)

featureCounts -T 4 -a $2 -o "$fileshort".txt $1

