import re

# Read the input file
input_file = "../folded_proteins/scripting_too_big_for_ESMFold/Loki-ASV2_OOM_name_conversion.txt"
output_file = "output_AF2_location_with_indices.txt"

# Dictionary to store entries by index
entries = {}

# Parse the input file
with open(input_file, "r") as file:
    for line in file:
        # Split the line by whitespace
        columns = line.strip().split()
        if len(columns) != 2:
            continue
        
        # Extract the first and second columns
        column1, column2 = columns[0], columns[1]
        
        # Extract the index from the second column (e.g., LOKIASV2_2492)
        match = re.search(r"LOKIASV2_(\d+)", column2)
        if match:
            index = int(match.group(1))
            entries[index] = column1

# Determine the maximum index to size the output file
max_index = max(entries.keys())

# Write the output file with entries at the correct indices
with open(output_file, "w") as file:
    for i in range(1, max_index + 1):
        if i in entries:
            file.write(f"{entries[i]}\n")
        else:
            file.write("\n")  # Leave the row blank if no entry exists
