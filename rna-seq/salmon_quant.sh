#!/usr/bin/env bash
#SBATCH -J salmon
#SBATCH --partition=long
#SBATCH --mem=2G
#SBATCH --cpus-per-task=4

# Forward reads = $1
# Reverse reads = $2
# Index = $3

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate rna-seq

short=$(basename $1 | sed s/"_F_paired.fastq.gz"//g)

ReadF=$1
ReadR=$2
Index=$3

salmon quant \
    -i $Index \
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
