#!/usr/bin/env bash
#SBATCH -J medaka
#SBATCH --partition=long
#SBATCH --mem=10G
#SBATCH --cpus-per-task=8

# reads = $1
# ref assembly = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate medaka

fileshort=$(basename $1 | sed s/".fastq.gz"//g)

mkdir $fileshort
medaka_haploid_variant -i $1 -r $2 -o ./$fileshort -t 8
