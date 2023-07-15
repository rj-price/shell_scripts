#!/usr/bin/env bash
#SBATCH -J satsumasynteny
#SBATCH --partition=long
#SBATCH --mem=40G
#SBATCH --cpus-per-task=16

##########################################################################
#INPUT:
# 1st argument: Genome1
# 2nd argument: Genome2
#OUTPUT:
# File is synteny alignment between two input genomes

export SATSUMA2_PATH=/mnt/shared/scratch/jnprice/apps/conda/pkgs/satsuma2-20161123-h9f5acd7_4/bin

SatsumaSynteny2 -t $1 -q $2 -o $3

