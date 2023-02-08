#!/usr/bin/env bash
#SBATCH -J busco
#SBATCH --partition=long
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8

# assembly (in .fasta format) = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate busco

fileshort=$(basename $1 | sed s/".fasta"//g)
busco -m genome -c 8 -i $1 -o BUSCO_$fileshort -l /mnt/shared/scratch/jnprice/private/busco_downloads/lineages/hypocreales_odb10
