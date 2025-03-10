import pandas as pd #imports so you can use 'pd' instead of 'pandas'
import argparse

#arguments for parsing arguments
parser = argparse.ArgumentParser(prog='PDB_download_fromcsv', description='Takes the PDB column and returns alist of PDB IDs in one line, separated by commas')
parser.add_argument('-f', '--filename', type=str) #describes what the arguments it takes
parser.add_argument('-c', '--colname', type=str)
parser.add_argument('-o', '--outfile', type=str)
args = parser.parse_args() #stores arguments as a list
print(args)

df = pd.read_csv(args.filename) # will read data frame to get the information from parse args instead of you changing code
print(df[str(args.colname)])

#to turn it into a csv file of lists and remove NaNs
df[str(args.colname)].dropna().to_csv(args.outfile, header=False, index=False, lineterminator=",")
