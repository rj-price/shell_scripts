#!/usr/bin/env bash
#SBATCH -J BUSCOphylo
#SBATCH --partition=medium
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4

# busco results dir = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate BUSCO_phylogenomics

python ~/scratch/apps/BUSCO_phylogenomics/count_buscos.py -i $1 > single_copy_counts.txt

python ~/scratch/apps/BUSCO_phylogenomics/BUSCO_phylogenomics.py -i $1 -o output_busco_phylogenomics -t 4 --supermatrix_only

iqtree -nt AUTO -s output_busco_phylogenomics/supermatrix/SUPERMATRIX.phylip -B 1000
