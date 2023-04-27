#!/usr/bin/env bash
#SBATCH -J BRAKER
#SBATCH --partition=long
#SBATCH --mem=40G
#SBATCH --cpus-per-task=1

# softmasked genome = $1
# rna alignments = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate BRAKER_env

SPECIES=$(basename $1 | sed s/".msk"//g)

RNA=$(ls /mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/annotation/alignment/"$SPECIES"*bam | tr '\n' ',')

braker.pl --species=$SPECIES --genome=$1 --prot_seq=/mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/annotation/orthodb.fa \
    --workingdir=/mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/annotation/BRAKER2/$SPECIES \
    --bam=$RNA --etpmode --softmasking --cores=1 --gff3 \
    --AUGUSTUS_CONFIG_PATH=/mnt/shared/scratch/jnprice/apps/Augustus/config \


