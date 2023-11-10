#!/usr/bin/env bash
#SBATCH -J bwa-mem
#SBATCH --partition=medium
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8

# ref assembly = $1
# F reads = $2
# R reads = $3

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate gatk

short=$(basename $2 | sed s/".fastq.gz"//g)

bwa mem -t 8 $1 $2 $3 > $short.sam

samtools flagstat -@ 8 $short.sam

samtools view -@ 8 -bS $short.sam -o $short.bam
samtools sort -@ 8 $short.bam -o "$short"_sorted.bam
samtools index -@ 8 "$short"_sorted.bam
