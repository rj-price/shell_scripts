#!/usr/bin/env bash
#SBATCH -J quickmerge
#SBATCH --partition=long
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8

# assembly 1 = $1
# assembly 2 = $2
# assembly 3 = $3

merge_wrapper.py $1 $2 $3 -pre 123
merge_wrapper.py $1 $2 -pre 12
merge_wrapper.py $1 $3 -pre 13
merge_wrapper.py $2 $3 -pre 23

