# About

`R` script to pull down the [College Scorecard](https://collegescorecard.ed.gov/data/)
and put into workable format(s) for data analysis.

## The file

The TDE file I created [can be found here](https://dl.dropboxusercontent.com/u/15276022/scorecard.tde)

__NOTE__:  This was just my first pass at creating the file.  There is room for improvement.

## Setup

This assumes that you have `R` installed and access to [Tableau](http://tableausoftware.com/).

To install the necessary `R` libraries, simply type the following commands
at the basic `R` prompt.

```r
install.packages("stringr")
install.packages("dplyr")
```

## Quick overview of the process.

1.  Download the data with `R`
2.  Unzip the files with `R`
3.  Loop through the `csv` files and merge together  
  - there is some basic data cleaning that needs to happen because the data types change
4.  save out the datasets into various `R` formats and csv
5.  Read the `csv` into Tableau and extract the data to a `TDE`

It should be possible to mirror this process in python and cut-out the Tableau
step all together, but to me, this is the most straight-forward approach.

## Notes about the data

1.  The data contains `Null` for null values.  Not ideal, and I didnt not clean these to be missing values.


## Future Improvements

- Port this script to `python` and leverage the tableau tde api.
-- using the desktop app to read the csv and create the TDE is painfully slow
- clean the Null values

