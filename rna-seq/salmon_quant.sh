#!/usr/bin/env bash
#SBATCH -J salmon
#SBATCH --partition=long
#SBATCH --mem=2G
#SBATCH --cpus-per-task=4

# Library 1 forward reads = $1
# Index = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

short=$(basename $1 | sed s/"_EKRN.*.fastq.gz"//g)

ReadF=$(ls /mnt/shared/scratch/jnprice/av_plant_rna/trimmed/"$short"*F_paired.fastq.gz | tr '\n' ' ')
ReadR=$(ls /mnt/shared/scratch/jnprice/av_plant_rna/trimmed/"$short"*R_paired.fastq.gz | tr '\n' ' ')

salmon quant \
    -i $2 \
    -l A \
    -1 $ReadF \
    -2 $ReadR \
    --validateMappings \
    -p 4 \
    --numBootstraps 1000 \
    --dumpEq \
    --seqBias \
    --gcBias \
    -o "$short"_quant
