#!/usr/bin/env bash
#SBATCH -J SNPraxml
#SBATCH --partition=medium
#SBATCH --mem=24G
#SBATCH --cpus-per-task=4

# High quality SNPs vcf = $1

export MYCONDAPATH=/mnt/shared/scratch/jnprice/apps/conda
source ${MYCONDAPATH}/bin/activate sam_bcf_tools_env

short=$(basename $1 | sed s/".vcf"//g)

python ~/scripts/shell_scripts/phylogenies/vcf2phylip.py -i $1

python ~/scripts/shell_scripts/phylogenies/ascbias.py -p $short.min4.phy -o "$short"_final.phy

raxml-ng --all --msa "$short"_final.phy --model GTR+ASC_LEWIS --tree pars{10} --bs-trees 100