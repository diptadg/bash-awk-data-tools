# This script counts the empty cells for each column
BEGIN {
    # Set the field separator from the input argument in the main script
    FS = separator

    # Read the first line (column titles)
    getline header
    split(header, column_titles, FS)  # Split header into array using the separator
    num_columns = length(column_titles)  # Get the number of columns
}

# Skip the header line (NR > 1) and process data lines
NR > 1 {
    for (i = 1; i <= num_columns; i++) {
        # Check if the current field is empty or contains only spaces
        if ($i ~ /^[[:space:]]*$/) {
            empty_counts[i]++  # Increment the empty count for this column
        }
    }
}

# After processing all lines, print the empty count for each column
END {
    for (i = 1; i <= num_columns; i++) {
        print column_titles[i], ": ", empty_counts[i]
    }
}
