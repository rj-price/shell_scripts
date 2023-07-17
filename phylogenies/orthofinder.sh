#!/usr/bin/env bash
#SBATCH -J orthofinder
#SBATCH --partition=long
#SBATCH --mem=10G
#SBATCH --cpus-per-task=16

# proteome_dir = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate orthofinder

ulimit -Sn
ulimit -Hn
ulimit -n 4096
ulimit -Sn

/mnt/shared/scratch/jnprice/apps/OrthoFinder/orthofinder.py -M msa -t 16 -a 10 -f $1 
