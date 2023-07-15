#!/usr/bin/env bash
#SBATCH -J happy
#SBATCH --partition=long
#SBATCH --mem=20G
#SBATCH --cpus-per-task=8

# reads = $1
# assembly = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate happy-env

fileshort=$(basename $1 | sed s/"_1kb.fastq.gz"//g)

mkdir $fileshort
cd $fileshort

# Align ont long reads to the assembly
minimap2 -t 8 -ax map-ont $2 $1 --secondary=no | \
    samtools sort -o "$fileshort".bam -T tmp.ali

# Index output BAM file
samtools index "$fileshort".bam

# Obtain coverage histogram with sambamba
happy coverage -t 8 -d happy_output "$fileshort".bam

# Estimate Haploidy (manually input peak limits)
#happy estimate --limit-low 35 --limit-diploid 120 --limit-high 200 -S 102M \
#  -o happy_stats --plot happy_output/"$fileshort".bam.hist

# Estimate Haploidy (try to detect peaks and limits automatically)
happy autoest --size=40000000 --outstats=happy.stats --plot happy_output/"$fileshort".bam.hist


