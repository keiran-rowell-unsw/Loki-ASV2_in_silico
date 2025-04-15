import csv

input_file = "input.tsv"
output_file = "output.tsv"

# Open the input file and process it
with open(input_file, "r") as infile, open(output_file, "w", newline="") as outfile:
    reader = csv.reader(infile, delimiter="\t")
    writer = csv.writer(outfile, delimiter="\t")

    # Write headers if present
    headers = next(reader)
    writer.writerow(headers)

    for row in reader:
        original_annotation = row[0]
        foldseek_description = row[1]
        evalue = float(row[2])

        # Check if the original annotation is 'hypothetical protein' and e-value < E-12
        if original_annotation == "hypothetical protein" and evalue < 1e-12:
            row[0] = f"structural match to: {foldseek_description}"  # Replace with prepended text

        writer.writerow(row)

print(f"Processing complete. Updated file saved as {output_file}.")
