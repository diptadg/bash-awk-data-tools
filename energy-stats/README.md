# Energy stats

Author: Dipta Datta Gupta. Written for UWA CITS4407 (Assignment 1, 2025).

`renewable_stats` is a Bash script that reads a CSV file of yearly electricity generation by country and reports the **minimum** or **maximum** amount generated from **solar and wind** or from **coal**:

- for a **country** (given as a three-letter ISO code such as `AUS`), it reports the value and the year(s) in which it occurred;
- for a **year** (such as `2015`), it reports the value and the country/countries that produced it.

Ties are reported in full: if several years (or countries) share the minimum or maximum value, all of them are listed. Values are compared as numbers, so `0` and `0.00` count as the same value.

## Usage

```bash
./renewable_stats <csv file> <country_code | year> <solar_wind | coal> <min | max>
```

| Argument | Allowed values |
|---|---|
| `csv file` | Path to a non-empty CSV file in the format below |
| `country_code \| year` | A three-letter country code (letters only, case-sensitive) or a four-digit year |
| energy type | `solar_wind` or `coal` |
| operation | `min` or `max` |

## Input format

A comma-separated file with a header row and these five columns:

```
Country,Code,Year,SolarWindTWh,CoalTWh
```

- `Code` is a three-letter ISO country code.
- `SolarWindTWh` and `CoalTWh` are electricity generation in terawatt-hours, written with a decimal point.
- Fields must not contain commas.
- Both LF and CRLF line endings work.

## Examples

These commands use the synthetic sample in [`samples/energy_synthetic.csv`](samples/energy_synthetic.csv), which has three fictional countries (Northland `NRL`, Southmere `SMR`, Eastvale `EVL`) over 2020–2022. The output is real output from running the script on it.

```console
$ ./renewable_stats samples/energy_synthetic.csv NRL solar_wind max
The maximum amount of electrical energy produced from solar and wind by Northland was 19.3 TWh in the following year(s):
2022

$ ./renewable_stats samples/energy_synthetic.csv NRL coal min
The minimum amount of electrical energy produced from coal by Northland was 38.9 TWh in the following year(s):
2021
2022

$ ./renewable_stats samples/energy_synthetic.csv 2022 coal max
The maximum amount of electrical energy produced from coal in 2022 was 91.8 TWh by the following country/countries:
Southmere

$ ./renewable_stats samples/energy_synthetic.csv 2020 solar_wind min
The minimum amount of electrical energy produced from solar and wind in 2020 was 0 TWh by the following country/countries:
Eastvale
```

## Error handling

Every argument is checked before the file is read. Errors are printed to stderr and the script exits with status 1:

```console
$ ./renewable_stats samples/energy_synthetic.csv NRL coal
Error: Expected 4 arguments, but received 3.
Usage: ./renewable_stats <csv file path> <country_code | year> <'solar_wind' | 'coal'> <'min' | 'max'>

$ ./renewable_stats samples/no_such_file.csv NRL coal max
Error: The specified input file samples/no_such_file.csv does not exist or is empty.

$ ./renewable_stats samples/energy_synthetic.csv NR coal max
Error: Invalid identifier 'NR'. It should be a valid year or a 3-digit ISO country code (e.g., 'AUS' or 'USA' for a country code, or '1984' for a year).

$ ./renewable_stats samples/energy_synthetic.csv XYZ coal max
Invalid country code 'XYZ'. The country code is a three-letter ISO country code and is case-sensitive. Please verify and provide the correct country code in the argument

$ ./renewable_stats samples/energy_synthetic.csv 1984 coal max
No data found for the year '1984'.

$ ./renewable_stats samples/energy_synthetic.csv NRL gas max
Error: Unknown energy type 'gas'. Expected 'solar_wind' or 'coal'.

$ ./renewable_stats samples/energy_synthetic.csv NRL coal avg
Error: Unknown operation 'avg'. Expected 'min' or 'max'.
```

The script does not check the separator. A file that is not comma-separated produces "Invalid country code" or "No data found" instead of a separator error.

See the [top-level README](../README.md) for running the script on Windows (Git Bash) and Linux.

## Sample data

[`samples/energy_synthetic.csv`](samples/energy_synthetic.csv) is **synthetic**: the countries and values are invented to match the input format, and no rows come from the original dataset. The original dataset is not included in this repository.
