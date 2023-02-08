#!/usr/bin/env bash
#SBATCH -J busco
#SBATCH --partition=long
#SBATCH --mem-per-cpu=16G
#SBATCH --cpus-per-task=20


for file in ./*.fasta;
    do file_short=$(basename $file | sed s/".fasta"//g)
    busco -m genome -c 20 -i $file -o BUSCO_$file_short.fungi -l fungi_odb10
    done


