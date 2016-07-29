
library(googlesheets)
library(dplyr)
library(tidyr)
library(magrittr)
library(lubridate)

# Import my running log data via the Google spreadsheet API key 
raw_runs <- gs_key("1o4tM002LwAIJadUKbpS1GMPiOjdslHvMXi77W8Hhses") %>%
  gs_read()

# Clean and tidy raw data -----------------------------------------------------

cleaned <- raw_runs %>%
  # Remove any run that is shorter than 30 seconds or longer than 90 minutes
  filter(duration.seconds > 30, duration.seconds < 5400) %>%
  # Make dates consistent format
  # Add a duration in minutes column
  mutate(date             = parse_date_time(x      = date,
                                            orders = c("%a %d %b %Y %T", "mdy"), 
                                            tz     = "America/New_York"),
         duration.minutes = (duration.seconds / 60) %>% round(digits = 2),
         avg.pace         = (duration.minutes / total.distance) %>% round(digits = 2),
         month            = month(date),
         day              = day(date),
         year             = year(date))

  