#!/usr/bin/env python

import sys

def string_test(file=None):
    file = open(sys.argv[1],'r')

    d={"UPPER_CASE":0, "LOWER_CASE":0}
    for c in file:
        if c.isupper():
           d["UPPER_CASE"]+=1
        elif c.islower():
           d["LOWER_CASE"]+=1
        else:
           pass
    print ("No. of Upper case characters : ", d["UPPER_CASE"])
    print ("No. of Lower case Characters : ", d["LOWER_CASE"])
    print ("Percent of Lower case Characters : ", (d["LOWER_CASE"]/(d["LOWER_CASE"]+d["UPPER_CASE"]))*100)
if __name__ == '__main__':
        string_test(sys.argv[1])
