#!/usr/bin/env bash
#SBATCH -J SANS
#SBATCH --partition=long
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4

# genome dir = $1

ls $1/*fasta > genomes_list.fof

/mnt/shared/scratch/jnprice/apps/sans/SANS-autoN.sh -i genomes_list.fof -k 31 -v -f strict -N sans_genome_greedytree.new
