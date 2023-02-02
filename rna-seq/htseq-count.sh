#!/usr/bin/env bash
#SBATCH -J htseq
#SBATCH --partition=long
#SBATCH --mem=6G
#SBATCH --cpus-per-task=4

# sorted bam = $1
# transcriptome = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $1 | sed s/".sorted.bam"//g)

htseq-count -n 4 -s no -r pos -c "$fileshort".csv $1 $2


