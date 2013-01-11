#!/usr/bin/env python

import sys

if len(sys.argv) != 2:
    #sys.stderr.write('No input file.')
    print >> sys.stderr, 'No input file.'
    exit(1)

file_name = sys.argv[1]
file = open(file_name)
content = file.read()

pointer = content.find('wikicontent')
pointer = content.find('href', pointer)
pointer = pointer + 6
str_end = content.find('"', pointer)
print content[pointer:str_end]
