#!/usr/bin/env bash
#SBATCH -J busco
#SBATCH --partition=medium
#SBATCH --mem=8G
#SBATCH --cpus-per-task=8

# assembly (in .fasta format) = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate busco

fileshort=$(basename $1 | sed s/".fasta"//g)
busco -m protein -c 8 -i $1 -o BUSCO_$fileshort.fungi -l ~/busco_downloads/lineages/fungi_odb10

cp BUSCO_$fileshort/short* . 

rm -rf BUSCO_$fileshort
