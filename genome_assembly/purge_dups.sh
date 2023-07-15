#!/usr/bin/env bash
#SBATCH -J purge_dups
#SBATCH --partition=long
#SBATCH --mem=32G
#SBATCH --cpus-per-task=16

# assembly = $1
# ONT reads = $2

fileshort=$(basename $2 | sed s/".fastq.gz"//g)
mkdir $fileshort
cd $fileshort

echo $2 > pb.fofn
/mnt/shared/scratch/jnprice/apps/purge_dups/scripts/pd_config.py -n "$fileshort".json $1 pb.fofn

/mnt/shared/scratch/jnprice/apps/purge_dups/scripts/run_purge_dups.py -p bash "$fileshort".json /mnt/shared/scratch/jnprice/apps/purge_dups/bin "$fileshort"
