---
title: "Cleaning and transformation."
output: html_document
date: "2023-06-01"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Data transformation and cleaning

First, we load the packages that will be used for importing, cleaning, transforming, and analyzing the data.

```{r}
library(tidyverse)
library(skimr)
library(janitor)
library(here)
library(chron)
```

The databases are imported.

```{r}
dailyActivity_merged <- read.csv("G:/Otros ordenadores/Mi Portátil/Gaspar Facultad/Analisis de datos/Caso practico/Base de datos/dailyActivity_merged.csv")
```

```{r}
sleepDay_merge <- read.csv("G:/Otros ordenadores/Mi Portátil/Gaspar Facultad/Analisis de datos/Caso practico/Base de datos/sleepDay_merged.csv")
```

### Selection of variables of interest.

#### dailyActivity_merge

The daily_activity data frame is created based on the selection of variables of interest from the dailyActivity_merged dataset.

```{r}
daily_activity <- dailyActivity_merged %>%
  select(-TrackerDistance, -LoggedActivitiesDistance)
daily_activity <- daily_activity %>% 
  select(-Calories)
```

The name of the FairlyActiveMinutes column is changed to ModeratelyActiveMinutes.

```{r}
daily_activity <- daily_activity %>% 
  rename(ModeratelyActiveMinutes = FairlyActiveMinutes)
```

#### dailySleep_merge

The data in the SleepDay column is separated into two columns: one for date and another for time.

```{r}
sleep_day <- sleepDay_merge %>% 
  separate(SleepDay, into = c("date", "hour"), " ")
```

The time in the hour column is always the same. Therefore, we will only keep the date column.

```{r}
sleep_day %>% 
  select(hour) %>% 
  filter(hour != "12:00:00")
```

```{r}
sleep_day <- sleep_day %>% 
  select(-hour)
```

### Data type transformation.

The data in the necessary columns is transformed into date data type.

```{r}
daily_activity <- daily_activity %>% 
  mutate(ActivityDate = as.Date(ActivityDate, format = "%m/%d/%Y" ))
```

```{r}
sleep_day <- sleep_day %>% 
  mutate(date = as.Date(date ,format = "%m/%d/%Y"))
```

### Cleaning

The data outside the specified date range is searched for and removed.

```{r}
daily_activity %>% 
  filter(!between(ActivityDate, as.Date("2016-03-12"), as.Date("2016-05-12")))
```

In the daily_activity database, the total activity sum is checked to ensure it is not greater than 24 hours, which is equivalent to 1440 minutes.

```{r}
daily_activity %>% 
  filter(VeryActiveMinutes > 1440 |
           ModeratelyActiveMinutes > 1440 |
           LightlyActiveMinutes > 1440 |
           SedentaryMinutes > 1440)
```

### Summary of the data.

```{r}
glimpse(daily_activity)
```

```{r}
head(daily_activity)
```

```{r}
glimpse(sleep_day)
```

```{r}
head(sleep_day)
```

```{r}
knitr::kable( head(sleep_day))
```
