#!/usr/bin/env python

import argparse


ap = argparse.ArgumentParser()
ap.add_argument('--synteny',required=True,type=str,help='The genome assembly')
ap.add_argument('--contig_name',required=True,type=str,help='name of contig to change')
ap.add_argument('--existing_colour',required=True,type=str,help='existing colour')
ap.add_argument('--new_colour',required=True,type=str,help='new colour')
ap.add_argument('--outfile',required=True,type=str,help='output')

file = ap.parse_args()


file_in = open (file.synteny, "r")
file_out = open (file.outfile, "w")

name = file.contig_name
col1 = file.existing_colour
col2 = file.new_colour

line = file_in.readlines()


for element in line:
  element = element.split ("\t")
  if name == element [0]:
    element [6] = element [6].replace("color=" + col1, "color=" + col2)
  else:
    pass 
  data = [element [0], element [1], element [2], element [3], element [4], element [5], element [6]]
  out_line = "\t".join (data)
  print out_line
  file_out.write (out_line)
  file_out.write ("\n")


file_out.close()
file_in.close ()





 


