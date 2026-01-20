#{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message = FALSE)

library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(gridExtra)
library(grid)# For handling multiple plots

#{r load data}
counts <- read.csv("/Users/Hayden Kuttenkeuler/Desktop/sentinels-light-trap/data/Master_QAQC_LightTrap_Counts.csv") %>%
  filter(!Code %in% c("KLE", "BLU", "TAK", "PRI", "HOT", "MAS"))

# Exclude September data
counts <- counts %>% filter(Month != "Sep")

# Rename sites
counts$Site[counts$Site == "Pacific Science Enterprise Centre"] <- "DFO PSEC"
counts$Site[counts$Site == "Pacific Biological Station"] <- "DFO PBS"
counts$Site[counts$Site == "Institute of Ocean Sciences"] <- "DFO IOS"

# Convert date column to Date type
counts$Date <- ymd(counts$Date)
counts$Year <- factor(counts$Year)
counts$week <- week(counts$Date)  # Define week once

# Ensure loc.lat is ordered correctly
counts$loc.lat <- factor(counts$Site, levels = unique(counts$Site[order(counts$Lat, decreasing = TRUE)]))

#{r summarize data}
years <- c(2022, 2023, 2024, 2025)
total_weekly <- list()

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
        grid.arrange(grobs = plot_list, ncol = 1, nrow = 2)  # Exactly 2 plots per page
      }
      plot_list <- list()  # Reset plot list for the next page
    }
  }
}