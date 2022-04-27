#### Preamble ####
# Purpose: Simulate the desire dataset and test it
# Author: Tian Yi Zhang
# Date: 27 April 2022
# Contact: psyminette.zhang@mail.utoronto.ca
# License: MIT

#### Workspace set-up ####
library(ggplot2) # for graphs

### Simulate data ###
set.seed(6607)

# Simulate 100 observations
num_obs <- 100


simulate_data <-
  data.frame(
    age = rnorm(n = num_obs, mean = 25, sd = 10), # Players most likely in their 20s
    age_group = sample(x = c(1:6),
                       size = num_obs,
                       replace = TRUE
                       ),
    character_total = sample(x = c(1:11), # total number of characters
                             size = num_obs,
                             replace = TRUE
                             ),
    playtime_total = runif(num_obs, 0, 5000), # total playtime
    gender_main = sample(x = c("Female","Male"), # gender of main character
                         size = num_obs,
                         replace = TRUE
                         ),
    importance_vp = runif(num_obs, 1, 10), # rated importance of VP
    importance_bkom = runif(num_obs, 1, 10), # rated importance of BK and OM
    cm_vp_count = runif(num_obs, 0, 20), # expect people to buy 20 at most
    cm_bkom_count = runif(num_obs, 0, 20),
    ps_functional_usd = runif(num_obs, 0, 1000), # expect people to spend 500 at most
    ps_cosmetic_usd = runif(num_obs, 0, 1000),
    ps_total = runif(num_obs, 0, 1000) # total spending in-game
  )

ggplot(simulate_data, aes(x = importance_vp, y = cm_vp_count)) +
  geom_point() +
  geom_smooth(method = "lm")

# the simulated data suggests that there is a negative correlation between
# the rated importance of Value Packs and the amount of Value Packs people
# bought in the central market.
# might be the case in the real dataset?