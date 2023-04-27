#!/usr/bin/env bash
#SBATCH -J red
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# folder = $1

Red -gnm /mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/final-assemblies/repeat_masked/genome/$1 -frm 2 \
    -msk /mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/final-assemblies/repeat_masked/red/$1 \
    -rpt /mnt/shared/scratch/jnprice/ensa/plants/assembly/2021_assemblies/final-assemblies/repeat_masked/red/$1
