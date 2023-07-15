#!/usr/bin/env bash
#SBATCH -J necat
#SBATCH --partition=long
#SBATCH --mem=80G
#SBATCH --cpus-per-task=24

# necat config = $1

export PATH=$PATH:/mnt/shared/scratch/jnprice/apps/NECAT/Linux-amd64/bin

#DIR = realpath $1 | xargs dirname
#cd $DIR

fileshort=$(basename $1 | sed s/"_config.txt"//g)
necat.pl correct $1 && necat.pl assemble $1 && necat.pl bridge $1
cp $fileshort/6-bridge_contigs/polished_contigs.fasta ../"$fileshort"_necat.fasta
