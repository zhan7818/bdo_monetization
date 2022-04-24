#### Preamble ####
# Purpose: Clean the Dataset
# Author: Tian Yi Zhang
# Date: 22 April 2022
# Contact: psyminette.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(janitor)
library(pointblank)

# Read in the raw data. 
# Dataset was downloaded from survey in Google Forms. Columns names are
# already cleaned.
# Additional Cleaning done beforehand:
# - Total spending from packages is calculated based on packages
# purchased using excel
# - New column of 0 and 1; 1 if got the game for free
raw_data <- readr::read_csv("inputs/data/raw_data.csv")
         
#### Data Cleaning ####
# Remove malicious responses intended to sabotage the survey
# Row 45, 52, and 131 are obvious malicious responses
# Total playtime for row 49 is unreasonably high.
cleaned_data <- clean_names(raw_data[-c(45,49,52,131),])

#### New Variable Creation ####
# use mutate() to create an age group column
cleaned_data <- cleaned_data |>
  mutate(age_group = cut(age, c(12,22,32,42,52,62,101),
                         labels = c("13-22","23-32","33-42","43-52","53-62","63+")))

#### Dataset Validation ####
# Change the class of the variables so that they are considered factors when
# appropriate
cleaned_data <- cleaned_data |>
  mutate(age = as.numeric(age)) |>
  mutate(gender = as.factor(gender)) |>
  mutate(character_total = as.factor(character_total)) |>
  mutate(character_female = as.factor(character_female)) |>
  mutate(playtime_total = as.numeric(playtime_total)) |>
  mutate(playtime_main = as.numeric(playtime_main)) |>
  mutate(gender_main = as.factor(gender_main)) |>
  mutate(packages_usd = as.numeric(packages_usd)) |>
  mutate(package_free = as.factor(package_free)) |>
  mutate(importance_vp = as.numeric(importance_vp)) |>
  mutate(importance_bkom = as.numeric(importance_bkom)) |>
  mutate(cm_vp_count = as.numeric(cm_vp_count)) |>
  mutate(cm_bkom_count = as.numeric(cm_bkom_count)) |>
  mutate(ps_vp_usd = as.numeric(ps_vp_usd)) |>
  mutate(ps_bkom_usd = as.numeric(ps_bkom_usd)) |>
  mutate(cm_outfits = as.numeric(cm_outfits)) |>
  mutate(ps_cosmetic_usd = as.numeric(ps_cosmetic_usd)) |>
  mutate(ps_functional_usd = as.numeric(ps_functional_usd)) |>
  mutate(ps_total = as.numeric(ps_total))

# Create test agent
agent <-
  create_agent(tbl = cleaned_data) |>
  col_is_factor(columns = vars(gender,
                               character_total,
                               character_female,
                               gender_main,
                               package_free,
                               age_group
                               )) |>
  col_is_numeric(columns = vars(age,
                                playtime_total,
                                playtime_main,
                                packages_usd,
                                importance_vp,
                                importance_bkom,
                                cm_vp_count,
                                cm_bkom_count,
                                ps_vp_usd,
                                ps_bkom_usd,
                                cm_outfits,
                                ps_cosmetic_usd,
                                ps_functional_usd
                                )) |>
  col_vals_in_set(columns = gender,
                  set = c("Male", "Female","Other")) |>
  col_vals_in_set(column = gender_main,
                  set = c("Male", "Female")) |>
  col_vals_gte(columns = c(age,
                           playtime_total,
                           playtime_main,
                           packages_usd,
                           importance_vp,
                           importance_bkom,
                           cm_vp_count,
                           cm_bkom_count,
                           ps_vp_usd,
                           ps_bkom_usd,
                           cm_outfits,
                           ps_cosmetic_usd,
                           ps_functional_usd
                           ),
               value = 0) %>%
  interrogate()

agent

#### Save data ####
write_csv(cleaned_data, "outputs/data/cleaned_data.csv")
