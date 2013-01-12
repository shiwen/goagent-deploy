#!/usr/bin/env python

import sys

def get_url(file):
    content = file.read()
    pointer = content.find('wikicontent')
    pointer = content.find('href', pointer)
    pointer = pointer + 6
    str_end = content.find('"', pointer)
    print content[pointer:str_end]

if __name__ == "__main__":
    if len(sys.argv) < 2:
        get_url(sys.stdin)
    else:
        get_url(open(sys.argv[1]))
