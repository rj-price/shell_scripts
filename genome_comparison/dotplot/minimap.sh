#!/usr/bin/env bash
#SBATCH -J minimap
#SBATCH --partition=long
#SBATCH --mem=1G
#SBATCH --cpus-per-task=4

#INPUT:
# 1st argument: Genome1
# 2nd argument: Genome2

target=$1
query=$2
outdir=$3

minimap2 -x asm5 -t 16 $target $query > $outdir/minimap.paf
