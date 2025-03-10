# Small anonymous function courtsey of our LLM overlords 
#!/bin/bash

# Path to the mapping file
mapping_file="Loki-ASV2_OOM_name_conversion.txt"

# Function to rename files based on mapping
rename_files() {
	while IFS=$'\t' read -r old_name new_name; do
		# Skip empty lines or lines that don't contain exactly 2 columns
		if [[ -z "$old_name" || -z "$new_name" ]]; then
			continue
		fi

		# Check if the old file exists
		if [[ -e "$old_name" ]]; then
		# Rename the file
			mv "$old_name" "$new_name"
			echo "Renamed: $old_name -> $new_name"
		else
			echo "File not found: $old_name"
		fi
		done < "$mapping_file"
	}

# Run the rename function
rename_files



