library(scales)
ls(activity_minutes_avg)
#usage minutes graph
ggplot(activity_minutes_avg, 
       mapping = aes(x = 2,
                     y = Average,
                     fill = ActivityIntensity)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = Average),
            position = position_stack(vjust = 0.5), color = "black", size = 4) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("blue","red","green","yellow"))+
  theme_void()+
  labs(title = "Average minutes per activit")+
  xlim(0.5,2.5)
#usage minutes percentage graph
ggplot(activity_minutes_avg_percent, 
       mapping = aes(x = 2,
                     y = Average,
                     fill = ActivityIntensity)) +
  geom_bar(stat = "identity", color = "black") +
  geom_text(aes(label = percent(Average/100)),
            position = position_stack(vjust = 0.5), color = "black", size = 4) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("blue","red","green","yellow"))+
  theme_void()+
  labs(title = "Percentage of average minutes per activity")+
  xlim(0.5,2.5)

#association between distance of each intensity and usage minutes
ls(daily_activity)

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalActiviteMinutes, y =  VeryActiveDistance)) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalActiviteMinutes, y =  VeryActiveDistance))

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalActiviteMinutes, y = ModeratelyActiveDistance )) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalActiviteMinutes, y =  ModeratelyActiveDistance))

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalActiviteMinutes, y = LightActiveDistance )) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalActiviteMinutes, y = LightActiveDistance ))

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalActiviteMinutes, y = SedentaryActiveDistance )) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalActiviteMinutes, y = SedentaryActiveDistance ))

#association between minutes of each intensity and total distance
ls(daily_activity)

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalDistance, y =  VeryActiveMinutes)) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalDistance, y =  VeryActiveMinutes))

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalDistance, y =  ModeratelyActiveMinutes)) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalDistance, y =  ModeratelyActiveMinutes))


ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalDistance, y =  LightlyActiveMinutes)) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalDistance, y =  LightlyActiveMinutes))

ggplot(daily_activity)+
  geom_point(mapping = aes(x = TotalDistance, y =  SedentaryMinutes)) + 
  geom_smooth(method = "lm", se = FALSE, mapping = aes(x = TotalDistance, y =  SedentaryMinutes))
