This repo contains the code and data supporting the paper on the study of
monetisation methods used in Black Desert Online:

# Scripts

The scripts folder contains the 2 scripts utilized to simulate and clean the
dataset:

- The script used to simulate and test the desired dataset
is located in 00-simulation.R. This script includes simulations for the desired
dataset and tests set up to ensure that the simulation is representative of
the desire dataset. This script also helped formulate plans for the analysis
of the real dataset

- The script used to clean and prepare the data is called 
01-data_cleaning.R. This scripted cleaned up the data variables and set up
tests to ensure that the variables in the dataset are of the correct class and
values.

# Inputs

The inputs folder contains the raw data set stored in inputs/data/raw_data.csv.

The literature cited in this paper include:

- The 2021 fourth quarter earnings pdf by Acitivision Blizzard.

A PDF copy of the survey used to obtain the dataset can be found in
inputs/survey/bdo_survey.pdf.

# Outputs

The outputs folder contains two folders: `data` and `paper`.

- The `data` folder contains the cleaned_data, cleaned using the
01-data_cleaning.R script.
This is the dataset used for the analysis in this paper.

- The `paper` folder contains the Rmarkdown file used to construct this paper,
the pdf output of the said Rmarkdown file, and the BibTex file for the
references used in this paper. If you wish to view this paper,
open paper.pdf. If you wish to view the analysis process,
open paper.Rmd.