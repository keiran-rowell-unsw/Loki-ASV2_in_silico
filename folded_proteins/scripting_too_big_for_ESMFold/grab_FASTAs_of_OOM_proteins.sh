#!/bin/bash

# Input files
names_file="Loki-ASV2_OOM_big_proteins_list.txt"
input_file="../loki-ASV2_dfast_all_protein_ORFs.faa"
output_file="Loki-ASV2_OOM_proteins.faa"

# Create or clear the output file
: > "$output_file"

# Read each name from names_file
while IFS= read -r name; do
    # Search for lines containing the name and the following line
    grep -n -i "$name" "$input_file" | while IFS=: read -r line_number _; do
        # Extract the line number and write it along with the next line to the output file
        awk -v l="$line_number" 'NR == l || NR == l+1' "$input_file" >> "$output_file"
	cat "$output_file" >> OOM_proteins.faa
    done
done < "$names_file"

