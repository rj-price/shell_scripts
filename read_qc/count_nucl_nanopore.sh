#!/usr/bin/env bash
#SBATCH -J count_nucl
#SBATCH --partition=long
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=2

Reads=$1
Genome_size=$2
OutDir=$3
#CurDir=$PWD

#cp $1 $CurDir

#gunzip $Read_F

#Sub1=$(basename $1 | sed s/".fastq.gz"//g)

/mnt/shared/scratch/jnprice/apps/count_nucl.pl -i $Reads -g $2 > $OutDir/estimated_coverage.log

#rm $Sub1.fastq
