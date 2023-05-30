source("final_project.R")
source("map_income.r")

library(plotly)

# Create Plots -----------------------------------------------------------------
# Create change over time (built units) plot ----

# Filter data frame to census tracts in Chinatown (census tracts 90, 91)

# Create mask
chinatown_ct <- joined_df$GEO_ID == "1500000US530330090001" |
  joined_df$GEO_ID == "1500000US530330090002" |
  joined_df$GEO_ID == "1500000US530330091001" |
  joined_df$GEO_ID == "1500000US530330091002"

# Filter data frame for Chinatown
chinatown_filt_df <- joined_df[chinatown_ct,]

# Filter data frame to census tracts in Wallingford (census tracts 50, 51, 52)

# Create mask
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

# Group and summarize data frames by year for Chinatown

chinatown_grp_df <- group_by(chinatown_filt_df, YEAR_FINAL)

bu_per_yr_chinatown <- summarize(chinatown_grp_df,
                                 units_built = n_distinct(GEO_ID))

# Group and summarize data frames by year for Wallingford

wallingford_grp_df <- group_by(wallingford_filt_df, YEAR_FINAL)

bu_per_yr_wallingford <- summarize(wallingford_grp_df,
                                   units_built = n_distinct(GEO_ID))

# Create Chinatown bar graph
bar_bu_chinatown <- ggplot(data = bu_per_yr_chinatown, aes(x = YEAR_FINAL, y = units_built)) +
  geom_bar(stat = "identity") +
  geom_smooth(method=lm, se=FALSE)

plot(bar_bu_chinatown)

# Create Wallingford bar graph
bar_bu_wallingford <- ggplot(data = bu_per_yr_wallingford, aes(x = YEAR_FINAL, y = units_built)) +
  geom_bar(stat = "identity") +
  geom_smooth(method=lm, se=FALSE)

plot(bar_bu_wallingford)

# Create demographics plot ----

# Group and summarize data frames by year

chinatown_grp_df_2 <- group_by(chinatown_filt_df, YEAR_FINAL)

nonwhite_chinatown_df <- summarize(chinatown_grp_df_2,
                                   perc_nonwhite = mean(percNonWhite))

bar_nonwhite_chinatown <- ggplot(nonwhite_chinatown_df, aes(x = YEAR_FINAL, y = perc_nonwhite)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  labs(
    title = "Percentage of Non-White Residents in Chinatown (2013-2018)",
    x = "Year",
    y = "Percentage"
  )

plot(bar_nonwhite_chinatown)

wallingford_grp_df_2 <- group_by(wallingford_filt_df, YEAR_FINAL)

nonwhite_wallingford_df <- summarize(wallingford_grp_df_2,
                                     perc_nonwhite = mean(percNonWhite))

bar_nonwhite_wallingford <- ggplot(nonwhite_wallingford_df, aes(x = YEAR_FINAL, y = perc_nonwhite)) +
  geom_bar(stat = "identity") +
  geom_smooth(method=lm, se=FALSE)

plot(bar_nonwhite_wallingford)

#Find percentage of Black residents in all populations
joined_df$percBlack <- joined_df$totalEstBlack / joined_df$totalEstPop *100

#Find percentage of Asian residents in all populations
joined_df$percAsian <- joined_df$totalEstAsian/ joined_df$totalEstPop * 100

chinatown_filt_df$percAsian <- joined_df$percAsian[chinatown_ct]
#Find percentage of AIAN residents in all populations
joined_df$percAIAN <- joined_df$totalEstAIAN/ joined_df$totalEstPop * 100

#Find percentage of NHPI residents in all populations
joined_df$percNHPI <- joined_df$totalEstNHPI/ joined_df$totalEstPop * 100

#Find percentage of other residents in all populations
joined_df$percOther <- joined_df$totalEstOther / joined_df$totalEstPop * 100

#Bar plot for Asian demographic in Chinatown

# Group by and summarize
#chinatown_asian_dem_df <- group_by(chinatown_filt_df, YEAR_FINAL)

#asian_chinatown_df <- summarize(chinatown_asian_dem_df,
#perc_asian = median(percAsian))

#Create a stacked bar graph for all Non-White residents in Chinatown
#bar_asian_chinatown <- ggplot(data = asian_chinatown_df, aes(x = YEAR_FINAL, y = perc_asian)) +
#geom_bar(stat = "identity") +
#geom_smooth(method=lm, se=FALSE) +
#labs(
#title = "Percentage of Asian Residents in Chinatown (2013-2019)",
#x = "Year",
#y = "Percentage of Asian Residents"
#)


#plot(bar_asian_chinatown)

##Create a stacked bar graph for all Non-White residents in Wallingford
#wallingford_asian_dem_df <- group_by(wallingford_filt_df, YEAR_FINAL)

#asian_wallingford_df <- summarize(wallingford_asian_dem_df,
#  perc_asian = mean(percAsian))
#bar_asian_wallingford <- ggplot(data = asian_wallingford_df, aes(x= YEAR_FINAL, y = perc_asian)) +
# geom_bar(stat = "identity") +
#geom_smooth(method=lm, se = FALSE) +
#labs(
# titles = "Percentage of Asian Residents in Wallingford (2013-2019)",
#x = "Years",
#y = "Percentage of Asian Residents"
#)

#plot(bar_asian_wallingford)

# Create stacked white/nonwhite plot for Chinatown ----

# Group chinatown_filt_df by year 
cid_grp <- group_by(chinatown_filt_df, YEAR_FINAL)

# Summarize 
cid_w_df <- summarize(cid_grp,
                    perc = mean(percWhite),
                    group = "White")

cid_nw_df <- summarize(cid_grp,
                       perc = mean(percNonWhite),
                       group = "Non-white")

# Append
cid_df <- rbind(cid_nw_df, cid_w_df)

# Plot
cid_bar <- ggplot(cid_df, aes(x = YEAR_FINAL, y = perc, fill = group, text = perc)) +
  geom_bar(position="stack", stat="identity") + 
  labs(
    title = "Percentage of white vs. nonwhite residents (2013-2019)",
    x = "Year",
    y = "Percentage",
    fill = "Racial demographic"
  ) + theme(legend.spacing.y = unit(1, "cm")) +
  geom_smooth(method = 'lm', se = FALSE)

# Make interactive plot 
cid_bar + ylim(0,100)
cid_bar + geom_text()
cid_bar <- ggplotly(cid_bar, tooltip = "text")
cid_bar


# Create stacked white/nonwhite plot for Wallingford ----
wall_grp <- group_by(wallingford_filt_df, YEAR_FINAL)

# Summarize 
wall_w_df <- summarize(wall_grp,
                       perc = mean(percWhite),
                       group = "White")

wall_nw_df <- summarize(wall_grp,
                        perc = mean(percNonWhite),
                        group = "Non-white")

# Append 
wall_df <- rbind(wall_nw_df, wall_w_df)

# Plot 
wall_bar <- ggplot(wall_df, aes(x = YEAR_FINAL, y = perc, fill = group, text = perc)) +
  geom_bar(position="stack", stat="identity") +
  labs(
    title = "Percentage of white vs. nonwhite residents (2013-2019)",
    x = "Year",
    y = "Percentage",
    fill = "Racial demographic"
  ) +
  geom_smooth(method = 'lm', se = FALSE)


# Make interactive plot
wall_bar + ylim(0,100)
wall_bar + geom_text()
wall_bar <- ggplotly(wall_bar, tooltip = "text")

# Create line charts for demo/new units in Chinatown ----

cid_demo_df <- summarize(cid_grp,
                         total = sum(DEMO),
                         unit_status = "Demolished")

cid_new_df <- summarize(cid_grp,
                        total = sum(NEW),
                        unit_status = "Constructed")

cid_bu_df <- rbind(cid_demo_df, cid_new_df)

cid_line <- ggplot(cid_bu_df, aes(x = YEAR_FINAL, y = total, group = unit_status, color = unit_status, text = total)) +
  geom_line() +
  labs(
    title = "Number of Units Constructed and Demolished in Chinatown (2013-2019)",
    x = "Year",
    y = "Total Units",
    color = "Unit Status"
  )

cid_line + geom_text()
cid_line <- ggplotly(cid_line, tooltip = "text")

# Create line charts for demo/new units in Wallingford ----

wall_demo_df <- summarize(
  wall_grp,
  total = sum(DEMO),
  unit_status = "Demolished"
)

wall_new_df <- summarize(
  wall_grp,
  total = sum(NEW),
  unit_status = "Constructed"
)

wall_bu_df <- rbind(wall_new_df, wall_demo_df)

wall_line <- ggplot(wall_bu_df, aes(x = YEAR_FINAL, y = total, group = unit_status, color = unit_status, text = total)) +
  geom_line() +
  labs(
    title = "Number of Units Constructed and Demolished in Wallingford (2013-2019)",
    x = "Year",
    y = "Total Units",
    color = "Unit Status"
  )

wall_line + geom_text()
wall_line <- ggplotly(wall_line, tooltip = "text")


# Create grouped bar charts for income distribution in Chinatown ----
# Append income dfs for all years ----
all_inc_df <- rbind(inc_2013, inc_2014, inc_2015, inc_2016, inc_2017, inc_2018, inc_2019)

# Delete unnecessary columns ----
all_inc_df <- all_inc_df[,c(1:20, 37:39)]

# Create separate dfs for each separate percentage ----

df_10k <- all_inc_df[,c(1:4, 20)]
df_10k$income_bracket <- "10,000 or less"
names(df_10k)[names(df_10k) == "less_than_10k"] <- "Count"

df_10k_14.99k <- all_inc_df[,c(1:3, 5, 20)]
df_10k_14.99k$income_bracket <- "10,000 to 14,999"
names(df_10k_14.99k)[names(df_10k_14.99k) == "X10k_to_14.99k"] <- "Count"

df_15k_19.99k <- all_inc_df[,c(1:3, 6, 20)]
df_15k_19.99k$income_bracket <- "15,000 to 19,999"
names(df_15k_19.99k)[names(df_15k_19.99k) == "X15k_to_19.99k"] <- "Count"

df_20k_24.99k <- all_inc_df[,c(1:3, 7, 20)]
df_20k_24.99k$income_bracket <- "20,000 to 24,999"
names(df_20k_24.99k)[names(df_20k_24.99k) == "X20k_to_24.99k"] <- "Count"

df_25k_29.99k <- all_inc_df[,c(1:3, 8, 20)]
df_25k_29.99k$income_bracket <- "25,000 to 29,999"
names(df_25k_29.99k)[names(df_25k_29.99k) == "X25k_to_29.99k"] <- "Count"

df_30k_34.99k <- all_inc_df[,c(1:3, 9, 20)]
df_30k_34.99k$income_bracket <- "30,000 to 34,999"
names(df_30k_34.99k)[names(df_30k_34.99k) == "X30k_to_34.99k"] <- "Count"

df_35k_39.99k <- all_inc_df[,c(1:3, 10, 20)]
df_35k_39.99k$income_bracket <- "35,000 to 39,999"
names(df_35k_39.99k)[names(df_35k_39.99k) == "X35k_to_39.99k"] <- "Count"

df_40k_44.99k <- all_inc_df[,c(1:3, 11, 20)]
df_40k_44.99k$income_bracket <- "40,000 to 44,999"
names(df_40k_44.99k)[names(df_40k_44.99k) == "X40k_to_44.99k"] <- "Count"

df_45k_49.99k <- all_inc_df[,c(1:3, 12, 20)]
df_45k_49.99k$income_bracket <- "45,000 to 49,999"
names(df_45k_49.99k)[names(df_45k_49.99k) == "X45k_to_49.99k"] <- "Count"

df_50k_59.99k <- all_inc_df[,c(1:3, 13, 20)]
df_50k_59.99k$income_bracket <- "50,000 to 59,999"
names(df_50k_59.99k)[names(df_50k_59.99k) == "X50k_to_59.99k"] <- "Count"

df_60k_74.99k <- all_inc_df[,c(1:3, 14, 20)]
df_60k_74.99k$income_bracket <- "60,000 to 74,999"
names(df_60k_74.99k)[names(df_60k_74.99k) == "X60k_to_74.99k"] <- "Count"

df_75k_99.99k <- all_inc_df[,c(1:3, 15, 20)]
df_75k_99.99k$income_bracket <- "75,000 to 99,999"
names(df_75k_99.99k)[names(df_75k_99.99k) == "X75k_99.99k"] <- "Count"

df_100k_124.99k <- all_inc_df[,c(1:3, 16, 20)]
df_100k_124.99k$income_bracket <- "100,000 to 124,999"
names(df_100k_124.99k)[names(df_100k_124.99k) == "X100k_to_124.99k"] <- "Count"

df_125k_149.99k <- all_inc_df[,c(1:3, 17, 20)]
df_125k_149.99k$income_bracket <- "125,000 to 149,999"
names(df_125k_149.99k)[names(df_125k_149.99k) == "X125k_to_149.99k"] <- "Count"

df_150k_199.99k <- all_inc_df[,c(1:3, 18, 20)]
df_150k_199.99k$income_bracket <- "150,000 to 199,999"
names(df_150k_199.99k)[names(df_150k_199.99k) == "X150k_to_199.99k"] <- "Count"

df_200k <- all_inc_df[,c(1:3, 19, 20)]
df_200k$income_bracket <- "200k or more"
names(df_200k)[names(df_200k) == "X200k_or_more"] <- "Count"

# Append again ----
all_inc_df2 <- rbind(df_10k, df_10k_14.99k, df_15k_19.99k, df_20k_24.99k, df_25k_29.99k,
                     df_30k_34.99k, df_35k_39.99k, df_40k_44.99k, df_45k_49.99k, 
                     df_50k_59.99k, df_60k_74.99k, df_75k_99.99k, df_100k_124.99k, 
                     df_125k_149.99k, df_150k_199.99k, df_200k)

# Filter for CID -----
filt_cid <- all_inc_df2$GEO_ID == "1500000US530330090001" |
  all_inc_df2$GEO_ID == "1500000US530330090002" |
  all_inc_df2$GEO_ID == "1500000US530330091001" |
  all_inc_df2$GEO_ID == "1500000US530330091002"

cid_inc_df <- all_inc_df2[filt_cid,]

# Group and summarize by year and percent ----
grp <- group_by(cid_inc_df, Year, income_bracket)
cid_inc_df_2 <- summarize(grp, 
                          total = sum(Count))




# Create stacked bar charts for income distribution ----
# more specifically, the lowest and highest income brackets 

cid_inc_bar <- ggplot(df_10k[filt_cid,], aes(x = Year, y = Count)) +
  geom_bar(stat="identity")

cid_inc_bar_2 <- ggplot(df_200k[filt_cid,], aes(x = Year, y = Count)) +
  geom_bar(stat="identity")

# Create grouped bar charts for income distribution in Wallingford ----

# Filter data for Wallingford ----

filt_wall <- all_inc_df2$GEO_ID == "1500000US530330050001" |
  all_inc_df2$GEO_ID == "1500000US530330050002" |
  all_inc_df2$GEO_ID == "1500000US530330050003" |
  all_inc_df2$GEO_ID == "1500000US530330051001" |
  all_inc_df2$GEO_ID == "1500000US530330051002" |
  all_inc_df2$GEO_ID == "1500000US530330051003" |
  all_inc_df2$GEO_ID == "1500000US530330052001" |
  all_inc_df2$GEO_ID == "1500000US530330052002" |
  all_inc_df2$GEO_ID == "1500000US530330052003" |
  all_inc_df2$GEO_ID == "1500000US530330052004" |
  all_inc_df2$GEO_ID == "1500000US530330052005"

# Group by and summarize ----

wall_inc_10k_df <- df_10k[filt_wall,]
wall_inc_200k_df <- df_200k

grp_wall <- group_by(wall_inc_10k_df, Year, income_bracket)
wall_inc_df_2 <- summarize(grp_wall,
                           total = sum(Count))

# Create stacked bar charts 

wall_inc_bar <- ggplot(wall_inc_df_2, aes(x = Year, y = total)) +
  geom_bar(stat = "identity")