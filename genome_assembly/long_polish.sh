#!/usr/bin/env bash
#SBATCH -J long_polish
#SBATCH --partition=long
#SBATCH --mem=80G
#SBATCH --cpus-per-task=16

# reads = $1
# assembly = $2

fileshort=$(basename $2 | sed s/".fasta"//g)
/mnt/shared/scratch/jnprice/apps/raconnn/raconnn 1 $1 $2 > "$fileshort"_racon.fasta


export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate medaka

mkdir $fileshort
medaka_consensus -i $1 -d "$fileshort"_racon.fasta -o ./$fileshort -t 16 -m r941_min_high_g360
cp $fileshort/consensus.fasta "$fileshort"_medaka.fasta
rm -rf $fileshort

conda deactivate
