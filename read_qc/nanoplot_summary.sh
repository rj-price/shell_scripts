#!/usr/bin/env bash
#SBATCH -J nanoplot
#SBATCH --partition=short
#SBATCH --mem=4G
#SBATCH --cpus-per-task=2

# summary = $1
# output_dir = $2

NanoPlot -t 2 --summary $1 -o $2
