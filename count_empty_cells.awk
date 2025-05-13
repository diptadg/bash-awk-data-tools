# This AWK script counts the empty cells for each column in the provided data file
# This script is called from the empty_cells script having passed the file and separator as arguments
# Authorship: Dipta Datta Gupta 
BEGIN {
    # Set the field separator from the input argument in the main script
    FS = separator

    # Check if the separator exists in the header line
    if (index(header, separator) == 0) {
        print "Error: The specified separator ('" separator "') was not found in the file." > "/dev/stderr"
        exit 1
    }

    # Read the first line (column titles)
    getline header
    split(header, column_titles, FS)  # Split header into array using the separator
    num_columns = length(column_titles)  # Get the number of columns
}

# Skip the header line (NR > 1) and process data lines
NR > 1 {
    for (i = 1; i <= num_columns; i++) {
        # Check if the current field is empty or contains only spaces (Reference: https://stackoverflow.com/questions/559363/matching-a-space-in-regex)
        if ($i ~ /^[[:space:]]*$/) {
            empty_counts[i]++  # Increment the empty cell count for this column
        }
    }
}

# After processing all lines, print the empty cell count for each column
END {
    for (i = 1; i <= num_columns; i++) {
        print column_titles[i], ":", empty_counts[i]
    }
}
