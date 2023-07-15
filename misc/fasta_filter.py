#!/usr/bin/env python

import sys
#from sets import Set
from Bio import SeqIO

# USAGE: ./filter.py your_ids.txt IN.fasta OUT.fasta
# Where: your_ids.txt --> A file containing the identifiers including ">" you want to EXCLUDE, one identifier per line

def list_ids():
    """
    Return a set containing the identifiers presented in a file,
    line by line, starting with ">"
    """

    # read the first file given and generate a set (faster iteration respect lists

    identifiers = Set([])

    with open(sys.argv[1], 'r') as fi:
        for line in fi:
            line = line.strip()
            identifiers.add(str(line).replace(">", ""))

    return identifiers

def filter():
    """
    Writes a file containing only the sequences with identifiers NOT
    present in a set of identifiers
    """

    identifiers = list_ids()

    with open(sys.argv[2]) as original_fasta, open(sys.argv[3], 'w') as corrected_fasta:
        records = SeqIO.parse(original_fasta, 'fasta')
        for record in records:
            print(record.id)
            if record.id not in identifiers:
                SeqIO.write(record, corrected_fasta, 'fasta')

if __name__ == '__main__':
    filter()
