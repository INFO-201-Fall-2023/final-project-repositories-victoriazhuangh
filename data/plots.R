source("final_project.R")

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
                    group = "Percent White")

cid_nw_df <- summarize(cid_grp,
                       perc = mean(percNonWhite),
                       group = "Percent Non-white")

# Append
cid_df <- rbind(cid_nw_df, cid_w_df)

# Plot
cid_bar <- ggplot(cid_df, aes(x = YEAR_FINAL, y = perc, fill = group)) +
  geom_bar(position="stack", stat="identity")

# Create stacked white/nonwhite plot for Wallingford ----
wall_grp <- group_by(wallingford_filt_df, YEAR_FINAL)

# Summarzie 
wall_w_df <- summarize(wall_grp,
                       perc = mean(percWhite),
                       group = "Percent White")

wall_nw_df <- summarize(wall_grp,
                        perc = mean(percNonWhite),
                        group = "Percent Non-white")

# Append 
wall_df <- rbind(wall_nw_df, wall_w_df)

# Plot 
wall_bar <- ggplot(wall_df, aes(x = YEAR_FINAL, y = perc, fill = group)) +
  geom_bar(position="stack", stat="identity")

