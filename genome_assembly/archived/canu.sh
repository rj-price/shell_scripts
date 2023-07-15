#!/usr/bin/env bash
#SBATCH -J canu
#SBATCH --partition=long
#SBATCH --mem=40G
#SBATCH --cpus-per-task=32

# reads file = $1
# genome size = $2

fileshort=$(basename $1 | sed s/".fastq.gz"//g)
mkdir $fileshort

/mnt/shared/scratch/jnprice/apps/canu-2.2/bin/canu \
  -p "$fileshort"_canu \
  -d $fileshort \
  genomeSize="$2" \
  useGrid=false \
  maxMemory=40 \
  maxThreads=32 \
  -nanopore $1

cp $fileshort/"$fileshort"_canu.contigs.fasta "$fileshort"_canu.fasta
