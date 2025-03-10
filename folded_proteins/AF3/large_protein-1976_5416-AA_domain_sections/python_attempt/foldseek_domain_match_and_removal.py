import subprocess
import argparse
import csv

parser = argparse.ArgumentParser()
parser.add_argument('-t', '--target', type=str, required=True)
parser.add_argument('-q', '--query', type=str, required=True)
args = parser.parse_args()

alignment_file='aln.m8'
alignment_summary='aln_summary.tsv'
subprocess.call(['echo','"Hello world!"'])

#generate first alignment
foldseek_init = ['foldseek','easy-search','--format-output','query,target,evalue,tstart,tend',args.query,args.target,alignment_file,'tmp']
subprocess.call(foldseek_init)

# set the E-value cutoff where you stop accepting matches
eval_exp_cutoff=int(-3)
eval_exp=int(-20)
iter=0

while (eval_exp < eval_exp_cutoff):
    # generate domain alignment on this iteration
    alignment_file='aln_'+str(iter)+'.m8'
    # a clever person would not do this twice but nevertheless this fixes alignemnt_file and can be refactored 
    foldseek_query = ['foldseek','easy-search','--format-output','query,target,evalue,tstart,tend',args.query,args.target,alignment_file,'tmp']
    subprocess.call(foldseek_query)
    
    # fastest is to just append with the shell
    subprocess.run(f"cat {alignment_file} >> {alignment_summary}", shell=True) # Don't usually use shell=True but its expedient here 
  
    with open(alignment_file,'r') as file:
        reader = csv.DictReader(file, delimiter="\t", fieldnames=("query","target","evalue","tstart","tend"))
        print("LOOK HERE")
        for row in reader:
            print(row['query'], row['target'])

    iter+=1
