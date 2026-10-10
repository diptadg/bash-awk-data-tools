# bash-awk-data-tools

Two command-line tools written in Bash and awk for working with tabular data files. `energy-stats` answers min/max questions about electricity generation in a CSV file. `data-cleaning-pipeline` counts empty cells in a semicolon-separated board-game dataset, cleans it into a tab-separated file, and reports summary statistics. Both tools check their arguments and input files before doing any work, print errors to stderr and exit with a non-zero status on failure. Both were written for the UWA unit CITS4407 Open Source Tools and Scripting (2025).

## Tools

| Folder | What it does |
|---|---|
| [`energy-stats/`](energy-stats/) | `renewable_stats`: finds the minimum or maximum solar/wind or coal generation for a country code or a year, including ties. |
| [`data-cleaning-pipeline/`](data-cleaning-pipeline/) | `empty_cells` counts empty cells per column, `preprocess` cleans the raw file into a TSV, and `analysis` reports the most common mechanic and domain and two correlations. |

Each folder has its own README with usage, input format and example output.

## Skills shown

- **Bash scripting:** argument handling, conditionals, loops, arrays, `IFS`, here-strings and command substitution.
- **awk:** field splitting, per-column counters, numeric comparison and correlation calculated in a single pass.
- **Input validation:** argument count, file existence, empty files, separator checks, and allowed values for country codes, years, energy types and operations.
- **Error handling:** clear messages on stderr, non-zero exit codes, and data output kept on stdout so it can be piped or redirected.
- **Data cleaning:** separator conversion, decimal-comma to decimal-point conversion, removing non-ASCII characters and carriage returns, and filling missing IDs.

## Running the tools

The scripts need Bash and the standard text utilities (`awk`, `sed`, `grep`, `sort`, `cut`, `tr`).

**Linux**

```bash
git clone https://github.com/diptadg/bash-awk-data-tools.git
cd bash-awk-data-tools
energy-stats/renewable_stats energy-stats/samples/energy_synthetic.csv NRL coal min
```

**Windows (Git Bash)**

Install [Git for Windows](https://git-scm.com/download/win), open **Git Bash**, and run the same commands. The repository's `.gitattributes` keeps the scripts' Unix (LF) line endings on checkout, so they run in Git Bash even with `core.autocrlf=true`. If a script reports `$'\r': command not found`, the file has Windows (CRLF) line endings, for example because it was copied or edited outside Git. Clone the repository with Git instead.

## Sample data

Each tool has a `samples/` folder with a small **synthetic** input file. All names and values in these files are invented to match the input format, and no rows come from the original datasets. The original datasets are not included in this repository.

## Author

Dipta Datta Gupta
