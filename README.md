# CITS4407 Assignment 2
# Authorship: Dipta Datta Gupta

This project contains a set of Bash and AWK scripts specifically designed to get the count of empty cells, preprocess, and analyze a board games dataset file. The scripts ensure data consistency, handle missing values, and provide useful statistics about the dataset.

## Scripts Overview

### 1. `empty_cells`

 **Purpose:**  
A wrapper script that calls the `count_empty_cells.awk` AWK helper script.

**Features:**
- **Validates Input:** Checks that the input file exists, is not empty, and is a regular file.
- **Argument Check:** Ensures that the passed separator argument for the script is a semicolon (;).
- **Calling the Helper AWK script**: Calls the `count_empty_cells.awk` AWK helper script with the appropriate arguments and shows the empty cell count for the provided file at the end, simplifying usage for the end user.
---

**Usage:**

1. **Count empty cells in the data file:**
   ```bash
   ../Usage: <file> '<separator>' [Seperator must be enclosed in single-quotes]
   ```

**Output:**  
  Prints the column names along with the count of empty cells for each in the following format:
  <column_name>: <empty_cell_count>

**Note:**  
Make sure your input file is a semicolon-seperated file.

---

### 2. `count_empty_cells.awk`

**Purpose:**  
This AWK script counts the empty cells for each column in the provided semicolon-separated data file.

**Features:**
- **Column-wise Empty Cell Counting:** For each column, counts how many cells are empty or contain only whitespace.

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
- **Separator Check:** Ensures the data file contains semicolons as the separator, enforcing the expected delimiter.
- **ID Handling:** Detects and fills empty ID fields by incrementing the highest existing ID, ensuring uniqueness.
- **Data Cleaning:**  
  - Converts semicolons to tab separators.
  - Removes non-ASCII characters.
  - Converts Windows line endings to Unix line endings.
  - Replaces commas (,) with dots (.) for representing decimal places in columns that have floating-point numbers.

**Output:**  
  Produces a cleaned, tab-separated file named `cleaned_file.tsv`.

**Usage:**
```bash
./preprocess <input_file>
```
**Note:**  
Make sure your input file is a semicolon-seperated file.

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

**Output:**  
Prints a summary with the calculated statistics for each relevant column in the following format:
- The most popular game mechanics is <game_mechanic_name> found in <game_mechanic_count> games
- The most game domain is <game_domain_name> found in <game_domain_count> games
- The correlation between the year of publication and the average rating is <correlation_year_rating>
- The correlation between the complexity of a game and its average rating is <correlation_complexity_rating>

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