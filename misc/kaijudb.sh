#!/usr/bin/env bash
#SBATCH -J kaijudb
#SBATCH --partition=himem
#SBATCH --mem=250G
#SBATCH --cpus-per-task=8

kaiju-makedb -s nr_euk
