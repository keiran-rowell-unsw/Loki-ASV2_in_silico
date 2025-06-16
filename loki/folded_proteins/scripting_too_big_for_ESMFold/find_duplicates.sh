#!/bin/bash

#LLM generated

# Directory to search (current directory if not specified)
DIRECTORY="${1:-.}"

# Temporary file to hold the list of numbers
TEMP_FILE=$(mktemp)

# Find files that match the pattern and extract the numbers
find "$DIRECTORY" -type f -name 'LOKIASV2_*' | \
	  sed -E 's/.*LOKIASV2_([0-9]+).*/\1/' | sort | uniq -d > "$TEMP_FILE"

# Check if there are duplicate numbers
if [[ -s "$TEMP_FILE" ]]; then
	  echo "Files with duplicate numbers in their names:"
	    # Loop through each duplicate number
	      while read -r num; do
		          # Find and list files with the current duplicate number
			      find "$DIRECTORY" -type f -name "LOKIASV2_${num}*" -print
			        done < "$TEMP_FILE"
			else
				  echo "No files with duplicate numbers found."
fi

# Clean up temporary file
rm "$TEMP_FILE"

