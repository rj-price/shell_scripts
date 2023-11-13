#!/mnt/shared/scratch/jnprice/apps/conda/bin/python

'''
This program extracts all the GO annotations for each gene.
'''

import sys
import argparse
import re
from Bio import SeqIO
from collections import defaultdict

ap = argparse.ArgumentParser()
ap.add_argument('--interpro', '-i', required=True, type=str, help='The genome assembly')
ap.add_argument('--output', '-o', required=True, type=str, help='Output file to save results')
conf = ap.parse_args()

annot_dict = defaultdict(set)

with open(conf.interpro) as f:
    for line in f:
        line = line.rstrip()
        gene_id, *go_annotations = line.split("\t")
        go_annotations = set(re.findall("GO:.......", "\t".join(go_annotations)))
        if go_annotations:
            annot_dict[gene_id].update(go_annotations)

with open(conf.output, 'w') as output_file:
    for gene_id, annotation_set in annot_dict.items():
        output_file.write(gene_id + "\t" + ", ".join(annotation_set) + "\n")
