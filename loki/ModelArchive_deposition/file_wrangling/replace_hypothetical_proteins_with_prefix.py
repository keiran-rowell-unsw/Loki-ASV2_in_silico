import csv
from decimal import Decimal, InvalidOperation


input_file = "foldseek_annotations_input.tsv"
output_file = "output.tsv"

# Open the input file and process it
with open(input_file, "r") as infile, open(output_file, "w", newline="\n") as outfile:
    reader = csv.reader(infile, delimiter="\t")
    writer = csv.writer(outfile, delimiter="\t")

    # Write headers if present
    headers = next(reader)
    writer.writerow(headers)

    for row in reader:
        original_annotation = row[0]
        foldseek_description = row[1]
        evalue_str = row[2].strip()

        try:
                # Convert evalue to Decimal
                evalue = Decimal(evalue_str)
        except InvalidOperation:
                print(f"Warning: Invalid evalue '{evalue_str}' found. Skipping this row.")
                writer.writerow(row)
                continue

        # Check if the original annotation is 'hypothetical protein' and e-value < E-6
        if original_annotation == "hypothetical protein" and evalue < Decimal("1e-6"):
            row[0] = f"structural match to: {foldseek_description}"  # Replace with prepended text

        writer.writerow(row)

print(f"Processing complete. Updated file saved as {output_file}.")
