IndianArm <- read.csv("staroddi-data/2025/S13688_IndianArm_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
IndianArm$site <- "Indian Arm"

PenderHarbour <- read.csv("staroddi-data/2025/S13689_PenderHarbour_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
PenderHarbour$site <- "Pender Harbour"

df <- rbind(IndianArm, PenderHarbour)
write.csv(df, "staroddi-data/2025/test.csv")
