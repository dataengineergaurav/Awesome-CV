#!/bin/bash
# Expand LaTeX \input{} directives for Pandoc conversion
# Usage: ./expand-latex.sh input.tex output.tex

input_file="$1"
output_file="$2"
input_dir=$(dirname "$input_file")

# Process the input file and expand \input{} directives
while IFS= read -r line; do
    if [[ $line =~ \\input\{([^}]+)\} ]]; then
        # Extract the input file path
        input_path="${BASH_REMATCH[1]}"
        full_path="$input_dir/$input_path"
        
        # Check if file exists
        if [[ -f "$full_path" ]]; then
            # Replace \input{} with file contents
            cat "$full_path"
        else
            # If file doesn't exist, keep the original line
            echo "$line"
        fi
    else
        echo "$line"
    fi
done < "$input_file" > "$output_file"
