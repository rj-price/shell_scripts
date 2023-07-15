#!/usr/bin/env bash
#SBATCH -J kaiju
#SBATCH --partition=himem
#SBATCH --mem=125G
#SBATCH --cpus-per-task=16

# Reads/Assembly = $1


# Taxonomic analysis using Kaiju
kaiju -z 16 -t /projects/ensa/frankia/baiting_nodules/kaijudb/nodes.dmp -f /projects/ensa/frankia/baiting_nodules/kaijudb/kaiju_db_nr_euk.fmi -i $1 -o kaiju.out

# Add taxon names to Kaiju outputs
kaiju-addTaxonNames -u -p -t /projects/ensa/frankia/baiting_nodules/kaijudb/nodes.dmp -n /projects/ensa/frankia/baiting_nodules/kaijudb/names.dmp -i kaiju.out -o kaiju.names.out

# Create classification summary tables
kaiju2table -t /projects/ensa/frankia/baiting_nodules/kaijudb/nodes.dmp -n /projects/ensa/frankia/baiting_nodules/kaijudb/names.dmp -r genus -o kaiju_summary.tsv kaiju.out
