#!/usr/bin/env bash
#SBATCH -J topGO
#SBATCH --partition=medium
#SBATCH --mem=1G
#SBATCH --cpus-per-task=2

# INPUTS
genes_of_interest=$1    # list of gene names in txt file
GO_annotations=$2       # output from GO_table.py

out_dir=$(basename $genes_of_interest | sed s/".txt"//g)

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate r4-base

mkdir $out_dir

Rscript /home/jnprice/scripts/shell_scripts/functional_analysis/GO_enrichment.R \
    --genes_of_interest $genes_of_interest \
    --GO_annotations $GO_annotations \
    --out_dir $out_dir