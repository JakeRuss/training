###########################
# File: Collect.R
# Description: (1) Use gspreadr to collect training data from Google.
#              (2) Save the data to a local csv file.
# Date: 03/24/2015
# Author: Jake Russ
# Notes:
# To do:
############################

library("gspreadr") #devtools::install_github("jennybc/gspreadr")
library("dplyr")
library("magrittr")
library("lubridate")

# Create object with all sheets available to me
my_sheets <- list_sheets() # Will authenticate first time using

# Register the sheet that I want
reg_list <- register_ss("1wuNv-8oFdI4pviqs8MqKk_qThxMfTl_rZnFizkbSmJs")

# Load the training spreadsheet
training <- reg_list %>% get_via_csv()

# Clean the columns
training %<>% mutate(date = parse_date_time(date, orders = "mdy"))

# Save a copy to a csv file
write.csv(training, "training.csv", row.names = FALSE)
