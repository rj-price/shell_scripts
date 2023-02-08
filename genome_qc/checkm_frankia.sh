#!/usr/bin/env bash
#SBATCH -J checkm
#SBATCH --partition=long
#SBATCH --mem=40G
#SBATCH --cpus-per-task=8

# input_dir = $1

checkm taxonomy_wf genus Frankia -x fasta -t 8 $1 $1/checkm-frankia

