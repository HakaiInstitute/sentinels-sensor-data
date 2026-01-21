# 2025 Light Trap CPUE vs Salinity in Salish Sea sites


#{install libraries}
library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(gridExtra)
library(grid)

#EXTRACT CPUE
#Download CPUE (counts) and tease apart data we need (Site, Year, Date, Time, CPUE Night, CPUE hour?)

#{r load data}
counts <- read.csv("/Users/Hayden Kuttenkeuler/Desktop/sentinels-light-trap/data/Master_QAQC_LightTrap_Counts.csv") %>%
  filter(!Code %in% c("KLE", "BLU", "TAK", "PRI", "HOT", "MAS"))
counts <- counts %>% filter(Month != "Sep")

#{Rename sites}
counts$Site[counts$Site == "Pacific Science Enterprise Centre"] <- "DFO PSEC"
counts$Site[counts$Site == "Pacific Biological Station"] <- "DFO PBS"
counts$Site[counts$Site == "Institute of Ocean Sciences"] <- "DFO IOS"

#{Convert date column to Date type}
counts$Date <- ymd(counts$Date)
counts$Year <- factor(counts$Year)
counts$week <- week(counts$Date)  # Define week once


# Ensure loc.lat is ordered correctly
counts$loc.lat <- factor(counts$Site, levels = unique(counts$Site[order(counts$lat, decreasing = TRUE)]))


#{r summarize data}
years <- c(2025)
total_weekly <- list()





#EXTRACT SALINITY
#Download salinity data and tease apart data we need (Site, Date-Time, Salinity, Temp?)

salinity <- read.csv("/Users/Hayden Kuttenkeuler/Desktop/sentinels-sensor-data/staroddi-data/2025/combined_data.csv")
salinity <- salinity[, !names(salinity) %in% c("Velocity.m.sec.", "X", "Number", "Conduct.mS.cm.")]

salinity <- salinity %>%
  mutate(
    Date.Time = dmy_hms(Date.Time),  # parse date-time
    Date = as.Date(Date.Time),       # extract date (y-m-d)
    Time = format(Date.Time, "%H:%M:%S")  # extract time
  )

salinity <- salinity %>%
  rename(
    Site = site,
    Salinity = Salinity.psu.,
    Temperature = Temp..C.
  )


salinity_trimmed <- salinity %>%
  group_by(Site) %>%
  group_modify(~ {
    
    df <- .x
    
    # ---- FIRST TRIM: Spring (keep data AFTER jump > 11) ----
    spring_df <- df %>%
      filter(Date >= as.Date("2025-04-10"),
             Date <= as.Date("2025-05-30")) %>%
      mutate(diff = abs(Salinity - lag(Salinity)))
    
    spring_jump <- which(spring_df$diff > 11)[1]
    
    if (!is.na(spring_jump)) {
      spring_start_time <- spring_df$Date.Time[spring_jump]
      df <- df %>% filter(Date.Time >= spring_start_time)
    }
    
    # ---- SECOND TRIM: Fall (keep data BEFORE jump > 11) ----
    fall_df <- df %>%
      filter(Date >= as.Date("2025-08-15"),
             Date <= as.Date("2025-09-30")) %>%
      mutate(diff = abs(Salinity - lag(Salinity)))
    
    fall_jump <- which(fall_df$diff > 11)[1]
    
    if (!is.na(fall_jump)) {
      fall_end_time <- fall_df$Date.Time[fall_jump]
      df <- df %>% filter(Date.Time <= fall_end_time)
    }
    
    df
  }) %>%
  ungroup()


write.csv(
  salinity_trimmed,
  "/Users/Hayden Kuttenkeuler/Desktop/sentinels-sensor-data/salinity_trimmed.csv",
  row.names = FALSE
)




#merge CPUE and salinity data sets by Date (YMD) and Site

salCPUE <- merge(salinity, counts, by = c("Date", "Site"))


#Graph the Salinity VS CPUE with dates/time and site as the comparable units


for (year in years) {
  total_weekly[[as.character(year)]] <- counts %>%
    filter(Year == year) %>%
    group_by(Date) %>%  # FIX: Group by Date instead of week
    summarize(CPUE.total = sum(CPUE_Hour, na.rm = TRUE), .groups = "drop")
}

#{r graph, echo=FALSE, fig.height=10, fig.width=7}
sites <- c("Cowichan Bay", "Descanso Bay", "Ford Cove", "Heather Marina", "Quathiaski Cove",
           "Hope Bay", "Horseshoe Bay", "Indian Arm", "James Island Pier", "Miners Bay",
           "Pacific Biological Station", "Pender Harbour", "Retreat Cove", "Silva Bay",
           "Sooke", "Tofino", "Victoria International Marina", "Whaler Bay")

for (year in years) {
  # Create a title plot for each year
  year_title <- grid.text(paste("Catch Plots for", year), gp = gpar(fontsize = 20, fontface = "bold"))
  
  plot_list <- list()  # Store plots for grid.arrange()
  
  for (i in seq_along(sites)) {
    site <- sites[i]
    site_data <- counts %>% filter(Year == year, loc.lat == site)
    
    if (nrow(site_data) > 0) {
      p <- ggplot(site_data, aes(x = Date, y = CPUE_Hour)) +
        geom_line(data = total_weekly[[as.character(year)]], aes(x = Date, y = CPUE.total), col = "gray", alpha = 0.75) +
        geom_line() +
        ylab("CPUE (crabs per hour)") +
        ggtitle(paste("CPUE at", site, "in", year)) +
        theme_bw()
      
      plot_list[[length(plot_list) + 1]] <- p
    }
    
    # Every 2 plots, print them and start a new page
    if (length(plot_list) == 2 || i == length(sites)) {
      if (length(plot_list) > 0) {
        print(grid.arrange(grobs = plot_list, ncol = 1, nrow = 2))
        # Exactly 2 plots per page
      }
      plot_list <- list()  # Reset plot list for the next page
    }
  }
}
