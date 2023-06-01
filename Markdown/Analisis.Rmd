---
title: "Analisis"
output: html_document
date: "2023-06-01"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Analisis

## Frecuencias de uso

El primer paso fue hacer una tabla de frecuencias de uso del dispositivo. Teniendo en cuenta los dias en los que cada id registro informacion.

```{r}
daily_activity_frequency <- data.frame(daily_activity %>%
                                         group_by(Id) %>%
                                         summarize(min_date = min(ActivityDate),
                                                   max_date = max(ActivityDate)),
                                       table(daily_activity$Id))
```

```{r}
daily_activity_frequency <- daily_activity_frequency %>%
  select(-Var1)
```

```{r}
daily_activity_frequency
```

```{r}
sleep_day_frequency <- data.frame(sleep_day %>% 
                                    group_by(Id) %>% 
                                    summarize(min_date = min(date),
                                              max_date = max(date)),
                                  table(sleep_day$Id))
```

```{r}
sleep_day_frequency  <- sleep_day_frequency %>% 
  select(-Var1)
```

```{r}
sleep_day_frequency
```

### Promedios de dias de uso

```{r}
mean(daily_activity_frequency[ ,4])
```

```{r}
mean(daily_activity_frequency[ ,4])/31
```

En promedio los usuarios usan el dispositivo el 92% de los dias que dura el estudio, 28 de los 31 dias.

### Promedio de dias de uso al dormir

```{r}
mean(sleep_day_frequency[ ,4])
```

```{r}
mean(sleep_day_frequency[ ,4])/31
```

El dispositivo se usa en promedio a la hora de dormir, solo 17 de los 31 dias, aproximadamente un 55%.

## Uso del dispositivo por minutos de actividad

Se crea un data frame, que contenga unicamente las columnas de id, de los distintos tiempos de actividad, segun la intensidad de la misma y una ultima columna con la suma total de minutos de uso del dispositivo.

```{r}
activity_minutes
```

Se saca un promedio de minutos de uso, segun la intensidad de la actividad.

```{r}
activity_minutes_avg <- data.frame(VeryActiveMinutes = round(mean(activity_minutes$VeryActiveMinutes)),
           ModeratelyActiveMinutes = round(mean(activity_minutes$ModeratelyActiveMinutes)),
           LightlyActiveMinutes = round(mean(activity_minutes$LightlyActiveMinutes)),
           SedentaryMinutes = round(mean(activity_minutes$SedentaryMinutes))
           )
```

```{r}
activity_minutes_avg
```

```{r}
activity_minutes_avg_percent
```

## Coincidencias 

### Datos de actividad y datos de sueño

Para analisar los datos de actividad, en conjuntos con los datos de sueño, se crea un nuevo data frame. Contiene los datos de activad unicamente de los usuarios que registraron tambien activadad sobre el sueño.

Union de las columnas que nos interesa de cada data frame

```{r}
coincidences <- merge(sleep_day %>% 
        select(-TotalSleepRecords,
               date),
      daily_activity %>% 
        select(-VeryActiveDistance,
               -ModeratelyActiveDistance,
               -LightActiveDistance,
               -SedentaryActiveDistance),
      by.x = c("Id", "date"), by.y = c("Id","ActivityDate"))
```

Se agrega una columna con la suma total de los minutos de actividad.

```{r}
coincidences <- coincidences %>% 
  mutate(TotalActiveMinutes = 
           VeryActiveMinutes + 
           ModeratelyActiveMinutes +
           LightlyActiveMinutes +
           SedentaryMinutes)
```

```{r}
coincidences
```

## Correlacion entre las variables

Se crea una tabla de correlacion entre las variables. Esto para conocer el grado de relacion entre cada una de ellas y poder profundizar en el analisis.

```{r}
correlation <- daily_activity %>% 
  select(-Id, -ActivityDate)
```

```{r}
correlation <- cor(correlation)
```
