#!/usr/bin/env bash
#SBATCH -J checkm
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

checkm taxonomy_wf order Actinomycetales -x fasta ./ ./checkm
