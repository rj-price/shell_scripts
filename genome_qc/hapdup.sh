#!/usr/bin/env bash
#SBATCH -J hapdup
#SBATCH --partition=long
#SBATCH --mem=80G
#SBATCH --cpus-per-task=24

# reads = $1
# assembly = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate hapdup

fileshort=$(basename $1 | sed s/"_1kb.fastq.gz"//g)

mkdir $fileshort
cd $fileshort

minimap2 -ax map-ont -t 24 $2 $1 | samtools sort -o "$fileshort".bam
samtools index "$fileshort".bam

cp $2 ./assembly.fasta

/mnt/shared/scratch/jnprice/apps/hapdup/hapdup.py --assembly assembly.fasta --bam "$fileshort".bam --out-dir . -t 24 --rtype ont
