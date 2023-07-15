#!/usr/bin/env bash
#SBATCH -J phasebook
#SBATCH --partition=himem
#SBATCH --mem=300G
#SBATCH --cpus-per-task=24

# reads = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate phasebook

fileshort=$(basename $1 | sed s/".fastq.gz"//g)

mkdir $fileshort
cd $fileshort

python /mnt/shared/scratch/jnprice/apps/phasebook/scripts/phasebook.py -i $1 -t 24 -p ont -g small -x -o .



