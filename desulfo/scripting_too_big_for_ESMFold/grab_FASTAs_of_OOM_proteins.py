# LLM with a loop of for name in names..

# Define the input and output file names
names_file = 'desulfo-ASV2_OOM_big_proteins_list.txt'
source_file = '../sequence_files/protein.faa'
output_file = 'OOM_proteins.faa'

# Read names into a set for faster lookup
with open(names_file, 'r') as nf:
    names = {line.strip() for line in nf}

# Open the source file and output file
with open(source_file, 'r') as sf, open(output_file, 'w') as of:
    lines = sf.readlines()
    
    # Loop through the lines and search for names
    for i in range(len(lines)):
        line = lines[i].strip()
        for name in names: 
            if name in line:
                print(line)
                # Write the matching line and the next one (if it exists)
                of.write(line + '\n')
                if i + 1 < len(lines):
                    of.write(lines[i + 1])

print(f'Matching lines written to {output_file}')

# run the split command from the shell after this
# split -l 2 -a 3 -d OOM_proteins.faa desulfo_ASV2_OOM_prot_ --additional-suffix=.fasta
