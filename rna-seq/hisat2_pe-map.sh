#!/usr/bin/env bash
#SBATCH -J hisat2
#SBATCH --partition=long
#SBATCH --mem=14G
#SBATCH --cpus-per-task=16

# index_dir = $1
# F reads = $2
# R reads = $3

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

fileshort=$(basename $2 | sed s/"_F_paired.fastq.gz"//g)

hisat2 -p 16 -x $1 -1 $2 -2 $3 -S "$fileshort".sam --summary-file "$fileshort".summary

samtools sort -@ 16 -o "$fileshort".sorted.bam "$fileshort".sam

rm "$fileshort".sam
