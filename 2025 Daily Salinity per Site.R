# 2025 Light Trap daily salinity per Salish Sea sites


#{install libraries}
library(ggplot2)
library(dplyr)
library(tidyverse)
library(lubridate)
library(gridExtra)
library(grid)

ggplot(salinity_daily, aes(x = Date, y = Salinity, color = Site)) +
  geom_line() +
  labs(
    x = "Date",
    y = "Salinity (psu)",
    color = "Site",
    title = "Daily Mean Salinity by Site"
  ) +
  theme_bw()

dev.off()
dev.new()

ggplot(salinity_daily, aes(Date, Salinity, color = Site)) +
  geom_line() +
  theme_bw()

#individual site's salinity hightlighted

sites <- unique(salinity_daily$Site)

for (s in sites) {
  
  p <- ggplot() +
    geom_line(
      data = salinity_daily %>% filter(Site != s),
      aes(Date, Salinity, group = Site),
      color = "grey75",
      linewidth = 0.3
    ) +
    geom_line(
      data = salinity_daily %>% filter(Site == s),
      aes(Date, Salinity),
      color = "deeppink",
      linewidth = 0.6
    ) +
    labs(
      title = paste("Daily Salinity —", s),
      x = "Date",
      y = "Salinity (psu)"
    ) +
    theme_bw()
  
  print(p)
}

