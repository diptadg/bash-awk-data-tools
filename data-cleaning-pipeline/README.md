# Data-cleaning pipeline

Author: Dipta Datta Gupta. Written for UWA CITS4407 (Assignment 2, 2025).

This project contains a set of Bash and AWK scripts specifically designed to get the count of empty cells, preprocess, and analyze a board games dataset file. The scripts ensure data consistency, handle missing values, and provide useful statistics about the dataset.

The pipeline runs in three steps:

```
raw file (;-separated)  --empty_cells-->  empty-cell count per column
raw file (;-separated)  --preprocess-->   cleaned file (tab-separated)  --analysis-->  summary statistics
```

## Input format

`empty_cells` and `preprocess` take a raw, semicolon-separated text file with a header row and these 14 columns:

```
ID;Name;Year Published;Min Players;Max Players;Play Time;Min Age;Users Rated;Rating Average;BGG Rank;Complexity Average;Owned Users;Mechanics;Domains
```

- Decimal numbers use a comma (e.g. `7,45`).
- `Mechanics` and `Domains` hold comma-separated lists (e.g. `Hand Management, Set Collection`).
- Any cell can be empty, including `ID`.

`analysis` takes the tab-separated file produced by `preprocess` (same 14 columns). It uses `Year Published` (column 3), `Rating Average` (9), `Complexity Average` (11), `Mechanics` (13) and `Domains` (14), and these must not be empty.

## Example

These commands use the synthetic sample in [`samples/board_games_synthetic.txt`](samples/board_games_synthetic.txt). It has 8 invented games, including one with no ID, a few empty cells and one name with a non-ASCII character. The output below is real output from running the scripts on it.

```console
$ ./empty_cells samples/board_games_synthetic.txt ';'
ID : 1
Name : 0
Year Published : 0
Min Players : 0
Max Players : 0
Play Time : 0
Min Age : 1
Users Rated : 0
Rating Average : 0
BGG Rank : 1
Complexity Average : 0
Owned Users : 1
Mechanics : 0
Domains : 0

$ ./preprocess samples/board_games_synthetic.txt > board_games_clean.tsv
$ grep -E 'Velvet|Pebble' board_games_clean.tsv
9	Velvet Comet	2021	3	6	30	8	640	6.55		1.40	1200	Dice Rolling, Hand Management	Party Games, Family Games
8	Pebble Caf	2023	2	4	20	8	310	6.20	1890	1.25	700	Set Collection, Tile Placement	Family Games

$ ./analysis board_games_clean.tsv
The most popular game mechanic is Hand Management found in 5 games
The most popular domain is Strategy Games found in 5 games
The correlation between the year of publication and the average rating is -0.090
The correlation between the complexity of a game and its average rating is 0.642
```

In the cleaned file, the game with no ID was given ID `9` (the highest existing ID plus one), decimal commas became dots, and the non-ASCII `é` in "Pebble Café" was removed.

Errors go to stderr and the scripts exit with status 1:

```console
$ ./empty_cells samples/board_games_synthetic.txt ','
Error: Separator must be a semicolon (;).
$ ./analysis samples/board_games_synthetic.txt
Error: The specified input file samples/board_games_synthetic.txt is not a tab-seperated file.
```

The scripts can be run from any directory, e.g. `data-cleaning-pipeline/empty_cells data-cleaning-pipeline/samples/board_games_synthetic.txt ';'`. See the [top-level README](../README.md) for running them on Windows (Git Bash) and Linux.

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
   ./empty_cells <file> ';'
   ```
   The separator must be enclosed in single quotes so the shell does not treat `;` as the end of the command.

**Output:**  
  Prints the column names along with the count of empty cells for each in the following format:
  `<column_name> : <empty_cell_count>`

**Note:**  
Make sure your input file is a semicolon-separated file.

---

### 2. `count_empty_cells.awk`

**Purpose:**  
This AWK script counts the empty cells for each column in the provided semicolon-separated data file.

**Features:**
- **Column-wise Empty Cell Counting:** For each column, counts how many cells are empty or contain only whitespace.

**Usage:**  
This script is run automatically by `empty_cells`, which loads it from the same folder.

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
  Outputs a cleaned version of the input data file to stdout.

**Usage:**
```bash
./preprocess <input_file> > <cleaned_file.tsv>
```
**Note:**  
Make sure your input file is a semicolon-separated file.

---

### 4. `analysis`

**Purpose:**
Performs statistical analysis on the cleaned board games dataset that uses tabs as field separators.

**Features:**  
 The script provides insights into the dataset such as:
- It calculates the most popular game mechanic
- It calculates the most popular game domain
- Correlation between year and average rating.
- Correlation between complexity and average rating.

**Output:**  
Prints a summary with the calculated statistics for each relevant column in the following format:
- The most popular game mechanic is <game_mechanic_name> found in <game_mechanic_count> games
- The most popular domain is <game_domain_name> found in <game_domain_count> games
- The correlation between the year of publication and the average rating is <correlation_year_rating>
- The correlation between the complexity of a game and its average rating is <correlation_complexity_rating>

**Usage:**
```bash
./analysis <input_file>
```

---

**Note:**  
Make sure to preprocess your data with the `preprocess` script before running the analysis to ensure consistent formatting and clean input.
Make sure your input file is a tab-separated file.

## Notes

- The scripts are designed to work together for robust data cleaning and analysis.
- Ensure that your input files use the correct separator as required by each script.
- Error messages are printed to standard error for easier debugging.
- The file in `samples/` is **synthetic**: every game name and value in it is invented to match the input format, and no rows come from the original dataset. The original dataset is not included in this repository.