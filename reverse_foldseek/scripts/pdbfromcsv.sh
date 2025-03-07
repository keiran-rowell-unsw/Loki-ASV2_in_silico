#!/bin/bash

filename=$1
colname=$2
outfile=$3


python3 pdb_download_fromcsv.py -f $filename -c $colname -o $outfile  #takes arguments from the shell and pass it to the python scripts
./batch_download.sh -f $3 -p 
gunzip *.gz
