#!/usr/bin/env python

import sys
import numpy as np
import pandas as pd

def stats_concat(file=None):
	iterations = len(sys.argv)-1

	master = pd.read_csv(sys.argv[1], sep = '\t', index_col = 'Unnamed: 0')
	
	i = 2

	while i <= iterations:
		df = pd.read_csv(sys.argv[i], sep = '\t', index_col = 'Unnamed: 0')
		master = master.append(df)
		i += 1

	master.to_csv('master.stats', sep = '\t', index = True)

if __name__ == '__main__':
	stats_concat(sys.argv[1:])
