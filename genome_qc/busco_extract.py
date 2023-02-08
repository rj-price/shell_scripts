#!/usr/bin/env python

import sys
import pandas as pd

def busco_extract(file=None):
    busco_dict = {
            'Complete':[0],
            'Single Copy':[0],
            'Duplicated':[0],
            'Fragmented':[0],
            'Missing':[0]
    }

    sing = 0
    dupl = 0
    frag = 0
    miss = 0

    with open(sys.argv[1], 'r') as fin:
            for line in fin:
                    if "Complete and single-copy BUSCOs" in line:
                        sing = int(line.split("\t")[1])
                    elif "Complete and duplicated BUSCOs" in line:
                        dupl = int(line.split("\t")[1])
                    elif "Fragmented BUSCOs" in line:
                        frag = int(line.split("\t")[1])
                    elif "Missing BUSCOs" in line:
                        miss = int(line.split("\t")[1])

    total = sing + dupl + frag + miss

    busco_dict['Single Copy'] = float(round(sing / float(total) * 100, 1))
    busco_dict['Duplicated'] = float(round(dupl / float(total) * 100, 1))
    busco_dict['Fragmented'] = float(round(frag / float(total) * 100, 1))
    busco_dict['Missing'] = float(round(miss / float(total) * 100, 1))
    busco_dict['Complete'] = busco_dict['Single Copy'] + busco_dict['Duplicated']

    filename = sys.argv[1]
    name = filename.split('.')[3]
    df = pd.DataFrame(busco_dict, index=[name])
    print(df)
    df.to_csv(name+'.busco', sep='\t', index=True)


if __name__ == '__main__':
    busco_extract(sys.argv[1])
