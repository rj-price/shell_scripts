#!/usr/bin/env bash
#SBATCH -J count_nucl
#SBATCH --partition=long
#SBATCH --mem-per-cpu=4G
#SBATCH --cpus-per-task=2

Read_F=$(basename $1)
Read_R=$(basename $2)
Genome_size=$3
OutDir=$4
CurDir=$PWD

cp $1 $CurDir
cp $2 $CurDir

gunzip $Read_F
gunzip $Read_R

Sub1=$(basename $1 | sed s/".fastq.gz"//g)
Sub2=$(basename $2 | sed s/".fastq.gz"//g)

/mnt/shared/scratch/jnprice/apps/count_nucl.pl -i $Sub1.fastq -i $Sub2.fastq -g $3 > $OutDir/estimated_coverage.log

rm $Sub1.fastq
rm $Sub2.fastq
