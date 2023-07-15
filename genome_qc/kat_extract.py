#!/usr/bin/env python

import sys
import pandas as pd

def kat_extract(file=None):
    kat_dict = {
            'Genome Size':[0],
            'Heterozygosity':[0],
            'Completeness':[0],
    }

    genome_size = ""
    hetero = ""
    complete = ""

    with open(sys.argv[1], 'r') as fin:
            for line in fin:
                    if "Estimated genome size:" in line:
                        genome_size = (line.split(" ")[3])+(line.split(" ")[4])
                    elif "Estimated heterozygous rate:" in line:
                        hetero = line.split(" ")[3]
                    elif "Estimated assembly completeness:" in line:
                        complete = line.split(" ")[3]
                    elif "Input 1 is a sequence file." in line:
                        filename = line.split("(")[1]


    kat_dict['Genome Size'] = genome_size
    kat_dict['Heterozygosity'] = hetero
    kat_dict['Completeness'] = complete
    
    name = filename.split('.')[0]
    df = pd.DataFrame(kat_dict, index=[name])
    print(df)
    df.to_csv(name+'.kat', sep='\t', index=True)


if __name__ == '__main__':
    kat_extract(sys.argv[1])
