#!/usr/bin/env bash
#SBATCH -J InterProScan
#SBATCH --partition=medium
#SBATCH --mem=20G
#SBATCH --cpus-per-task=16

# Assign all available (default) InterProScan terms and GO terms to genes in a proteome file

proteome=$1

# Change '*' STOP to 'X' STOP:
sed -i -r 's/\*/X/g' $proteome

/mnt/shared/scratch/jnprice/apps/interproscan/interproscan-5.65-97.0/interproscan.sh \
    -i $proteome \
    -goterms \
    -cpu 16 -dp -f tsv