#!/usr/bin/env bash
#SBATCH -J busco
#SBATCH --partition=long
#SBATCH --mem=24G
#SBATCH --cpus-per-task=16

# assembly (in .fasta format) = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate busco

fileshort=$(basename $1 | sed s/".fasta"//g)
busco -m genome -c 16 -i $1 -o BUSCO_$fileshort -l poales_odb10
