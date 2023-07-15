#!/usr/bin/env bash
#SBATCH -J kat-comp
#SBATCH --partition=long
#SBATCH --mem=48G
#SBATCH --cpus-per-task=16

# F reads file = $1
# R reads file = $2
# genome size = $3

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate kat

fileshort=$(basename $3 | sed s/"_1kb.*.fasta"//g)
cat $1 $2 > "$fileshort"_reads.fq.gz

kat comp -t 16 -h -m 21 -o $fileshort "$fileshort"_reads.fq.gz $3

