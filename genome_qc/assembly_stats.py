#!/usr/bin/env python

'''
Purpose: calculate some basic stats of an assembly.
Note: most of the ideas were from the web.
Usage: python assembly_stats.py xxx.fa
'''

import os
import sys
from collections import OrderedDict
import numpy as np
import pandas as pd

def assembly_stats(file=None):
    '''
    given an assembly (fasta), return some basic stats (total base, %GC, N50, number, min, max, avg, N90, %N or %gap)
    '''
    stats_dict = {
        "Size_includeN":0,
        "Size_withoutN":0,
        "Seq_Num":0,
        "Mean_Size":0,
        "Median_Size":0,
        "Longest_Seq":0,
        "Shortest_Seq":0,
        "GC_Content (%)":0,
        "N50":0,
        'L50':0,
        "N90":0,
        "Gap (%)":0
        }

    seqLen = []
    no_c, no_g ,no_a ,no_t ,no_n = 0, 0, 0, 0, 0

    tmp_len = 0
    with open(file, 'r') as fin:
        for line in fin:
            line = line.strip()
            if line.startswith('>'):
                if tmp_len == 0:
                    continue
                else:
                    seqLen.append(tmp_len)
                    tmp_len = 0
                    continue
            else:
                tmp_len += len(line)
                line = line.lower()
                no_c += line.count('c')
                no_g += line.count('g')
                no_a += line.count('a')
                no_t += line.count('t')
                no_n += line.count('n')
    seqLen.append(tmp_len)

    seqLen = sorted(seqLen, reverse=True)

    N50_pos = sum(seqLen) * 0.5
    N90_pos = sum(seqLen) * 0.9

    tmp_sum = 0
    L50 = 0
    for value in seqLen:
        tmp_sum += value
        L50 += 1
        if N50_pos <= tmp_sum:
            N50 = value
            break

    tmp_sum = 0
    for value in seqLen:
        tmp_sum += value
        if N90_pos <= tmp_sum:
            N90 = value
            break

    stats_dict["Size_includeN"] = int(sum(seqLen))
    stats_dict["Size_withoutN"] = int(sum(seqLen) - no_n)
    stats_dict["Seq_Num"] = int(len(seqLen))
    stats_dict["Mean_Size"] = int(np.mean(seqLen))
    stats_dict["Median_Size"] = int(np.median(seqLen))
    stats_dict["Longest_Seq"] = int(max(seqLen))
    stats_dict["Shortest_Seq"] = int(min(seqLen))
    stats_dict["GC_Content (%)"] = round(float((no_g + no_c)*100)/float(no_t + no_a + no_g + no_c), 2)
    stats_dict["N50"] = int(N50)
    stats_dict['L50'] = int(L50)
    stats_dict["N90"] = int(N90)
    stats_dict["Gap (%)"] = round(float(no_n * 100)/sum(seqLen), 2)

 #   for key in stats_dict:
 #       print key + '\t' + str(stats_dict[key])
    name = os.path.splitext(sys.argv[1])
    print(name[0])
    df = pd.DataFrame(stats_dict, index=[name[0]])
    print(df)
    df.to_csv(name[0]+'.stats', sep = '\t', index = True)

if __name__ == '__main__':
    assembly_stats(sys.argv[1])

