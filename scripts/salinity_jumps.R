library(dplyr)
library(ggplot2)


df <- read.csv("staroddi-data/2025/combined_data.csv")

indianarm <- subset(df, site == "Indian Arm")
indianarm$jump <- 0
for(i in 1:nrow(indianarm)) {
  row <- indianarm[i,]
  if (i == 1) {
    indianarm[i,"jump"] <- 0
  }
  else {
    indianarm[i,"jump"] <- indianarm[i, "Salinity.psu."] - indianarm[i-1, "Salinity.psu."]
  }
}

hist(indianarm$jump)
typeof(indian)
table(cut(
  indianarm$jump, 
  breaks = seq(min(indianarm$jump, na.rm = TRUE), ceiling(max(indianarm$jump, na.rm = TRUE)), by = 1),
  include.lowest = TRUE, 
  right = FALSE))
