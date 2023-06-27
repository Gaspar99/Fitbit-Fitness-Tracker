#frequency of user ID
daily_activity_frequency <- data.frame(daily_activity %>%
                                         group_by(Id) %>%
                                         summarize(min_date = min(ActivityDate),
                                                   max_date = max(ActivityDate)),
                                       table(daily_activity$Id))

daily_activity_frequency <- daily_activity_frequency %>%
  select(-Var1)

sleep_day_frequency <- data.frame(sleep_day %>% 
                                    group_by(Id) %>% 
                                    summarize(min_date = min(date),
                                              max_date = max(date)),
                                  table(sleep_day$Id))

sleep_day_frequency  <- sleep_day_frequency %>% 
  select(-Var1)

#frequency of usage analysis

#daily_activity_frequency 
#average usage days
mean(daily_activity_frequency[ ,4])
mean(daily_activity_frequency[ ,4])/31


#sleep_day
mean(sleep_day_frequency[ ,4])
sd(sleep_day_frequency[ ,4])

sd(sleep_day_frequency[ ,4])/mean(sleep_day_frequency[ ,4])

sleep_day_frequency %>% 
  arrange(-Freq)

#device usage in minutes
daily_activity %>% 
  select(VeryActiveMinutes, 
         ModeratelyActiveMinutes, 
         LightlyActiveMinutes) %>% 
  mutate(TotalMinutes = apply(daily_activity[, c("VeryActiveMinutes",
                                  "ModeratelyActiveMinutes", 
                                  "LightActiveDistance")], 2, sum))

activity_minutes <- daily_activity %>% 
  select(Id, VeryActiveMinutes, ModeratelyActiveMinutes, LightlyActiveMinutes, SedentaryMinutes) %>% 
  mutate(TotalActiveMinutes = VeryActiveMinutes + ModeratelyActiveMinutes + LightlyActiveMinutes + SedentaryMinutes)

#average minutes of usage based on activity intensity

activity_minutes_avg <- data.frame(VeryActiveMinutes = round(mean(activity_minutes$VeryActiveMinutes)),
           ModeratelyActiveMinutes = round(mean(activity_minutes$ModeratelyActiveMinutes)),
           LightlyActiveMinutes = round(mean(activity_minutes$LightlyActiveMinutes)),
           SedentaryMinutes = round(mean(activity_minutes$SedentaryMinutes))
           )

activity_minutes_avg_percent <- data.frame(VeryActiveMinutes = round(mean(activity_minutes$VeryActiveMinutes)),
                                           ModeratelyActiveMinutes = round(mean(activity_minutes$ModeratelyActiveMinutes)),
                                           LightlyActiveMinutes = round(mean(activity_minutes$LightlyActiveMinutes)),
                                           SedentaryMinutes = round(mean(activity_minutes$SedentaryMinutes))
)

activity_minutes_avg_percent <- round(prop.table(activity_minutes_avg_percent)*100)

activity_minutes_avg_percent <- gather( activity_minutes_avg_percent, key = "ActivityIntensity", value = "Average", VeryActiveMinutes:SedentaryMinutes)

#percentage of users who used the device throughout the entire day
count(activity_minutes %>% 
        select(TotalActiveMinutes) %>% 
        filter(TotalActiveMinutes == 1440))
478/940*100

#coincidences between activity and sleep data

coincidences <- merge(sleep_day %>% 
        select(-TotalSleepRecords,
               date),
      daily_activity %>% 
        select(-VeryActiveDistance,
               -ModeratelyActiveDistance,
               -LightActiveDistance,
               -SedentaryActiveDistance),
      by.x = c("Id", "date"), by.y = c("Id","ActivityDate"))

coincidences <- coincidences %>% 
  mutate(TotalActiveMinutes = 
           VeryActiveMinutes + 
           ModeratelyActiveMinutes +
           LightlyActiveMinutes +
           SedentaryMinutes)

unique(coincidences$Id)

#association between usage time and activity intensity

daily_activity <- daily_activity %>% 
  mutate(TotalActiviteMinutes = 
           VeryActiveMinutes + 
           ModeratelyActiveMinutes + 
           LightlyActiveMinutes + 
           SedentaryMinutes)
daily_activity <- daily_activity %>% 
  select(-TotlaMinutesActiviteMinute)

correlation <- daily_activity %>% 
  select(-Id, -ActivityDate)

correlation <- mutate_all(correlation, as.numeric)

correlation <- cor(correlation)

data.frame(correlation)

view(
correlation[c(1,6:9)]
)

tablaprueba <-  kable(daily_activity)

