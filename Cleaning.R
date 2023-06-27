#Packages for data cleaning and analysis.
install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")
install.packages("here")
install.packages("chron")
library(tidyverse)
library(skimr)
library(janitor)
library(here)
library(chron)

#daily_activity database:
#selection of variables of interest
daily_activity <- dailyActivity_merged %>%
  select(-TrackerDistance, -LoggedActivitiesDistance)
daily_activity <- daily_activity %>% 
  select(-Calories)
daily_activity <- daily_activity %>% 
  rename(ModeratelyActiveMinutes = FairlyActiveMinutes)
#data summary
str(daily_activity)

#changing data type of ActivityDate to date
daily_activity <- daily_activity %>% 
  mutate(ActivityDate = as.Date(ActivityDate, format = "%m/%d/%Y" ))

#search and removal of data outside the date range
daily_activity %>% 
  filter(!between(ActivityDate, as.Date("2016-03-12"), as.Date("2016-05-12")))
#no hay fechas fuera del rango 

#sum of minutes greater than those in a day(1440)
view(
daily_activity %>% 
  filter(VeryActiveMinutes > 1440 |
           FairlyActiveMinutes > 1440 |
           LightlyActiveMinutes > 1440 |
           SedentaryMinutes > 1440)
)

apply(daily_activity[ ,9],2,max)
apply(daily_activity[ ,9],2,max)
apply(daily_activity[ ,9],2,max)

#sleep_day database
#separation of date and time
sleep_day <- sleep_day %>% 
  separate(SleepDay, into = c("date", "hour"), " ")

#changing data type to date and time
sleep_day <- sleep_day %>% 
  mutate(date = as.Date(date ,format = "%m/%d/%Y"))

sleep_day <- sleep_day %>% 
  mutate(hour = times(hour))

#since all the data is from the same hour, the "hour" column does not provide us with meaningful information
sleep_day %>% 
  select(hour) %>% 
  filter(hour != "12:00:00")

sleep_day <- sleep_day %>% 
  select(-hour)





