source("final_project.R")

library(plotly)

#Filter Chinatown specific dataframes
chinatown_ct <- joined_df$GEO_ID == "1500000US530330090001" |
  joined_df$GEO_ID == "1500000US530330090002" |
  joined_df$GEO_ID == "1500000US530330091001" |
  joined_df$GEO_ID == "1500000US530330091002"

# Filter data frame for Chinatown
chinatown_filt_df <- joined_df[chinatown_ct,]

#Add race percentage

#Black 
chinatown_filt_df$perc_black <- chinatown_filt_df$totalEstBlack/ chinatown_filt_df$totalEstPop *100

#Asian
chinatown_filt_df$perc_asian <- chinatown_filt_df$totalEstAsian/ chinatown_filt_df$totalEstPop *100

#AIAN
chinatown_filt_df$perc_aian <- chinatown_filt_df$totalEstAIAN / chinatown_filt_df$totalEstPop *100

#NHPI
chinatown_filt_df$perc_nhpi <- chinatown_filt_df$totalEstNHPI/ chinatown_filt_df$totalEstPop *100


# Create mask for Wallingford
wallingford_ct <- joined_df$GEO_ID == "1500000US530330050001" |
  joined_df$GEO_ID == "1500000US530330050002" |
  joined_df$GEO_ID == "1500000US530330050003" |
  joined_df$GEO_ID == "1500000US530330051001" |
  joined_df$GEO_ID == "1500000US530330051002" |
  joined_df$GEO_ID == "1500000US530330051003" |
  joined_df$GEO_ID == "1500000US530330052001" |
  joined_df$GEO_ID == "1500000US530330052002" |
  joined_df$GEO_ID == "1500000US530330052003" |
  joined_df$GEO_ID == "1500000US530330052004" |
  joined_df$GEO_ID == "1500000US530330052005"

# Filter data frame for Wallingford
wallingford_filt_df <- joined_df[wallingford_ct,]

#Add race percentages 

#Asian
wallingford_filt_df$perc_asian <- wallingford_filt_df$totalEstAsian / wallingford_filt_df$totalEstPop *100

#Black 
wallingford_filt_df$perc_black <- wallingford_filt_df$totalEstBlack / wallingford_filt_df$totalEstPop *100

#AIAN
wallingford_filt_df$perc_aian <- wallingford_filt_df$totalEstAIAN / wallingford_filt_df$totalEstPop *100

#NHPI
wallingford_filt_df$perc_nhpi <- wallingford_filt_df$totalEstNHPI / wallingford_filt_df$totalEstPop *100

#Create stacked barchart For Chinatown

#group by Chinatown by year 
chinatown_filt_df <- group_by(chinatown_filt_df, YEAR_FINAL)

#summarize by race 
chinatown_asian <- summarize(chinatown_filt_df, 
                             perc = mean(perc_asian),
                             group = "Percent Asian"
                             )

chinatown_black <- summarize(chinatown_filt_df,
                             perc = mean(perc_black),
                             group = "Percent Black"
                             )

chinatown_aian <- summarize(chinatown_filt_df,
                             perc = mean(perc_aian),
                             group = "Percent AIAN"
)

chinatown_nhpi <- summarize(chinatown_filt_df,
                             perc = mean(perc_nhpi),
                             group = "Percent NHPI"
)

chinatown_race_df <- rbind(chinatown_asian,chinatown_black,chinatown_aian,chinatown_nhpi)

#Chinatown Non-White race_df 
chinatown_race_df <- group_by(chinatown_race_df, YEAR_FINAL)

#Barchart 
chinatown_bar <- ggplot(chinatown_race_df, aes(x = YEAR_FINAL, y = perc, fill = group,
                                               text = perc)) +
  geom_bar(position="stack", stat="identity") +
<<<<<<< Updated upstream
  labs ( fill = "Racial Makeup - Non-White", y = "Percentage", x = "Year") 

=======
  labs ( fill = "Racial Makeup - Non-White", y = "Percentage", x = "Year") #+
  #geom_smooth(method = 'lm', se = FALSE)
>>>>>>> Stashed changes

chinatown_bar <- chinatown_bar + ylim(0,100)

# Add interactivity 
chinatown_bar + geom_text()
chinatown_bar <- ggplotly(chinatown_bar, tooltip = "text")

#Add line chart 
cid_line_race_df <- group_by(chinatown_filt_df, YEAR_FINAL)

cid_line_race_df <- summarize(cid_line_race_df,
                              perc_Asian = mean(perc_asian),
                              perc_Black = mean(perc_black),
                              perc_AIAN = mean(perc_aian),
                              perc_NHPI = mean(perc_nhpi)
                              )
chinatown_line<- ggplot(cid_line_race_df, aes(x = YEAR_FINAL)) +
  geom_line(aes(y = perc_Asian), color = "forestgreen") +
  geom_line(aes(y = perc_Black), color = "red") +
  geom_line(aes(y = perc_AIAN), color = "blue") + 
  geom_line(aes(y = perc_NHPI), color = "purple") +
  labs( x = "Year" , y = "Race Distribution")

chinatown_line <- chinatown_line + ylim(0,100)

#add interactivity

#Create stacked barchart for Wallingford 

#group by Year 
wallingford_filt_df <- group_by(wallingford_filt_df, YEAR_FINAL)

#Summarize by race 
wallingford_asian <- summarize(wallingford_filt_df,
                               perc = mean(perc_asian),
                               group = "Percent Asian")

wallingford_black <- summarize(wallingford_filt_df,
                               perc = mean(perc_black),
                               group = "Percent Black")

wallingford_aian <- summarize(wallingford_filt_df,
                               perc = mean(perc_aian),
                               group = "Percent AIAN")

wallingford_nhpi <- summarize(wallingford_filt_df,
                               perc = mean(perc_nhpi),
                               group = "Percent NHPI")

wallingford_race_df <- rbind(wallingford_asian,wallingford_black,wallingford_aian,wallingford_nhpi)

#Barchart
wallingford_bar <- ggplot(wallingford_race_df, aes(x = YEAR_FINAL, y = perc, fill = group, 
                                                   text = perc)) +
  geom_bar(position="stack", stat="identity") +
<<<<<<< Updated upstream
  labs ( fill = "Racial Makeup - Non-White", y = "Percentage", x = "Year") 

=======
  labs ( fill = "Racial Makeup - Non-White", y = "Percentage", x = "Year") #+
  #geom_smooth(method = 'lm', se = FALSE)
>>>>>>> Stashed changes

wallingford_bar <- wallingford_bar + ylim(0,100)

# Add interactivity 
wallingford_bar + geom_text()
wallingford_bar <- ggplotly(wallingford_bar, tooltip = "text")

#turn into line chart 
w_line_race_df <- group_by(wallingford_filt_df, YEAR_FINAL)

w_line_race_df <- summarize(w_line_race_df,
                            perc_Asian = mean(perc_asian),
                            perc_Black = mean(perc_black),
                            perc_AIAN = mean(perc_aian),
                            perc_NHPI = mean(perc_nhpi),
                            )
wallingford_line <- ggplot(w_line_race_df, aes(x = YEAR_FINAL)) +
  geom_line(aes(y = perc_Asian), color = "forestgreen") +
  geom_line(aes(y = perc_Black), color = "red") +
  geom_line(aes(y = perc_AIAN), color = "blue") + 
  geom_line(aes(y = perc_NHPI), color = "purple") +
  labs( x = "Year" , y = "Race Distribution")
  
wallingford_line <- wallingford_line + ylim(0,100)
