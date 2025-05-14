# CITS4407 Project 2
# Authorship: Dipta Datta Gupta

This project contains a set of Bash and AWK scripts specifically designed to get the count of empty cells, preprocess, and analyze a board games dataset file. The scripts ensure data consistency, handle missing values, and provide useful statistics about the dataset.

## Scripts Overview

### 1. `empty_cells`

 **Purpose:**  
A wrapper script that calls `count_empty_cells.awk` with the appropriate arguments, simplifying usage for the end user.

---

## Usage Example

1. **Count empty cells in the cleaned file:**
   ```bash
   ../Usage: <file> '<separator>' [Seperator must be enclosed in single-quotes]
   ```

---

### 2. `count_empty_cells.awk`

**Purpose:**  
This AWK script counts the empty cells for each column in the provided data file.

**Features:**
- **Separator Validation:** Checks if the provided separator exists in the header line of the file.
- **Column-wise Counting:** For each column, counts how many cells are empty or contain only whitespace.
- **Output:**  
  Prints the column names along with the count of empty cells for each.

**Usage:**
```bash
This script will be run automatically with the empty_cells script
```

---

### 3. `preprocess`

**Purpose:** 
Cleans and transforms a raw data file that uses semicolons as field separators. The script performs the following operations:

**Features:**
- **Validates Input:** Checks that the input file exists, is not empty, and is a regular file.
- **Separator Check:** Ensures every line in the file contains a semicolon, enforcing the expected delimiter.
- **ID Handling:** Detects and fills empty ID fields by incrementing the highest existing ID, ensuring uniqueness.
- **Data Cleaning:**  
  - Converts semicolons to tabs for easier downstream processing.
  - Removes non-ASCII characters.
  - Converts Windows line endings to Unix format.
  - Replaces commas with dots in all columns except "Mechanics" and "Domains".
- **Output:**  
  Produces a cleaned, tab-separated file named `cleaned_file.tsv`.

**Usage:**
```bash
./preprocess <input_file>
```

---

### 4. `analysis`

**Purpose:**
Performs statistical analysis on the cleaned board games dataset that uses tabs as field seperators.

**Features:**  
 The script provides insights into the dataset such as:
- It calculates the most popular game mechanic
- It calculates the most popular game domain
- Correlation between year and average rating.
- Correlation between complexity and average rating.
- **Output:**  
Prints a summary table with the calculated statistics for each relevant column in the following format:
- The most popular game mechanics is <game_mechanic_name> found in <game_mechanic_count> games
- The most game domain is Strategy Games found in 77 games
- The correlation between the year of publication and the average rating is 0.226
- The correlation between the complexity of a game and its average rating is 0.426

**Usage:**
```bash
./analysis <input_file>
```

---

**Note:**  
Make sure to preprocess your data with the `preprocess` script before running the analysis to ensure consistent formatting and clean input.
Make sure your input file is a tab-seperated file.

## Notes

- The scripts are designed to work together for robust data cleaning and analysis.
- Ensure that your input files use the correct separator as required by each script.
- Error messages are printed to standard error for easier debugging.

---

## Authorship

- **Dipta Datta Gupta**  

---