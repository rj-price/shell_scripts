#!/usr/bin/python

import argparse


ap = argparse.ArgumentParser()
ap.add_argument('--synteny',required=True,type=str,help='The genome assembly')
ap.add_argument('--contig_prefix_1',required=True,type=str,help='prefix1')
ap.add_argument('--contig_prefix_2',required=True,type=str,help='prefix2')
ap.add_argument('--outfile',required=True,type=str,help='output')

file = ap.parse_args()


file_in = open (file.synteny, "r")
file_out = open (file.outfile, "w")

prefix1 = file.contig_prefix_1
prefix2 = file.contig_prefix_2

line = file_in.readlines()


for element in line:
  element = element.split ("\t")
  if "contig_" in element [0]:
    element [0] = element [0].replace("contig_", prefix1)
  if "contig_" in element [3]:
    element [3] = element [3].replace("contig_", prefix2)
  else:
    pass 
  data = [element [0], element [1], element [2], element [3], element [4], element [5]]
  out_line = "\t".join (data)
  print(out_line)
  file_out.write (out_line)
  file_out.write ("\n")


file_out.close()
file_in.close ()



 



