cleaningdatacoursera
====================

## Coursera Getting and Cleaning Data

This is the code for the Peer Assessed project; the code is contained
in a single source file which is extensively commented.

Additional information related to the variables and transformations is
described in CodeBook.md.

### Instructions:

* Clone this repo to your disk
* cd into the `cleaningdatacoursera` directory
* Run the script (using e.g. `R -f runAnalysis.R` in Unix systems, or using `source("runAnalysis.R")` from within an R shell opened in the directory)

The script will download and unzip the dataset (while checking for
already existing files and directories).

### Output

The script performs all the necessary operations and outputs two
files:

* `temp_data.csv`: a CSV file wich contains the merging of test and train data, with factors explicitly labelled and columns explicitly named (i.e. the dataset after steps 1-4).
* `final_data.csv`: a CVS file which is the tidy dataset that includes the average of all values according to subject and activity (the "independent dataset" asked for in the assignment, the dataset after step 5).

Both files can be read using `read.csv`.  Both files contain tidy datasets (in "wide" format) that adhere to the following rules (cf. 
"Tidy Data", Hadley Wickham, http://vita.had.co.nz/papers/tidy-data.pdf)

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.
