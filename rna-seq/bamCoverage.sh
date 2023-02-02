#!/usr/bin/env bash
#SBATCH -J bamCoverage
#SBATCH --partition=long
#SBATCH --mem=2G
#SBATCH --cpus-per-task=8

# sorted bam = $1

fileshort=$(basename $1 | sed s/".sorted.bam"//g)

samtools index -@ 8 -b $1

bamCoverage -p 8 --normalizeUsing RPKM -b $1 -o "$fileshort".bw
