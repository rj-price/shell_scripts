#!/usr/bin/env bash
#SBATCH -J dotplot
#SBATCH --partition=long
#SBATCH --mem=1G
#SBATCH --cpus-per-task=4

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate r4-base

#INPUT:
# 1st argument: paf file

paf=$1
outdir=$2

cd $outdir

dotplot=~/scripts/genome_comparison/dotplot
$dotplot/pafCoordsDotPlotly.R \
-i $paf \
-o paf_plot \
-m 2000 \
-q 50000 \
-k 10 \
-s -t -l -p 12

