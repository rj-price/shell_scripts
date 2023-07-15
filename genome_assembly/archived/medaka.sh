#!/usr/bin/env bash
#SBATCH -J medaka
#SBATCH --partition=long
#SBATCH --mem=120G
#SBATCH --cpus-per-task=16

# reads = $1
# assembly = $2

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda

source ${MYCONDAPATH}/bin/activate medaka

fileshort=$(basename $2 | sed s/".fasta"//g)
mkdir $fileshort
medaka_consensus -i $1 -d $2 -o ./$fileshort -t 16 -m r941_min_high_g360
cp $fileshort/consensus.fasta "$fileshort"_medaka.fasta
rm -rf $fileshort
