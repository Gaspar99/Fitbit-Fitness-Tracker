#paquetes para limpieza y analisis de los datos
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

#base de datos daily_activity:
#seleccion de las variables de interes
daily_activity <- dailyActivity_merged %>%
  select(-TrackerDistance, -LoggedActivitiesDistance)
daily_activity <- daily_activity %>% 
  select(-Calories)
daily_activity <- daily_activity %>% 
  rename(ModeratelyActiveMinutes = FairlyActiveMinutes)
#resumen de los datos
str(daily_activity)

#cambio de tipo de dato de ActivityDate a fecha
daily_activity <- daily_activity %>% 
  mutate(ActivityDate = as.Date(ActivityDate, format = "%m/%d/%Y" ))

#busqueda y eliminacion de datos fuera del rango de fechas
daily_activity %>% 
  filter(!between(ActivityDate, as.Date("2016-03-12"), as.Date("2016-05-12")))
#no hay fechas fuera del rango 

#suma de minutos mayores a los de un dia (1440)
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

#base de datos sleep_day
#separacion de la fecha y la hora
sleep_day <- sleep_day %>% 
  separate(SleepDay, into = c("date", "hour"), " ")

#cambio de tipo de dato a fecha y hora
sleep_day <- sleep_day %>% 
  mutate(date = as.Date(date ,format = "%m/%d/%Y"))

sleep_day <- sleep_day %>% 
  mutate(hour = times(hour))

#al ser todos los datos de la misma hora la columna hour no nos brinda informacion importante
sleep_day %>% 
  select(hour) %>% 
  filter(hour != "12:00:00")

sleep_day <- sleep_day %>% 
  select(-hour)





