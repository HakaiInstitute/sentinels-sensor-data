#===============================================================================
# Sentinels Salinity Data Reformatting
# Reformat salinity data to CSVs
#
# Input:
#     raw star-oddi CSVs with semi-colons instead of commas
#
# Output:
#     multiple salinity data CSVs with commas
#
# Erin Maher (Hakai Institute) erin.maher@hakai.org
# First Created 09/2025
# Last Updated 11/2025
#===============================================================================

#Cowichan S13850

cowichan_data <- read.csv(
  "S13850_Cowichan_2025/1S13850DAT.CSV",
  sep = ";",
  dec = ",",
  stringsAsFactors = FALSE,
  fileEncoding = "Latin1",
  check.names = FALSE
)
cowichan_data$'Date-Time' <- as.POSIXct(cowichan_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
cowichan_data$'Date-Time' <- format(cowichan_data$'Date-Time', "%d-%m-%Y %H:%M:%S")


write.csv(cowichan_data, "1S13850DAT_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")


------------------
#Descanso S13851
  
descanso_data <- read.csv(
    "S13851_Descanso_2025/1S13851DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )
descanso_data$'Date-Time' <- as.POSIXct(descanso_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
descanso_data$'Date-Time' <- format(descanso_data$'Date-Time', "%d-%m-%Y %H:%M:%S")


write.csv(descanso_data, "1S13851DAT_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

-------------------------------
  #Comox S13822
  
comox_data <- read.csv(
    "S13822_Comox_2025/2S13822DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

comox_data$'Date-Time' <- as.POSIXct(comox_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
comox_data$'Date-Time' <- format(comox_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(comox_data, "S13822_Comox_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

------------------
  #port moody S13833
  
portmoody_data <- read.csv(
    "S13833_PortMoody_2025/1S13833DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

portmoody_data$'Date-Time' <- as.POSIXct(portmoody_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
portmoody_data$'Date-Time' <- format(portmoody_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(portmoody_data, "S13833_PortMoody_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

-----------------------------
  #pender harbour S13689
  
penderharbour_data <- read.csv(
    "S13689_PenderHarbour_2025/1S13689DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

penderharbour_data$'Date-Time' <- as.POSIXct(penderharbour_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
penderharbour_data$'Date-Time' <- format(penderharbour_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(penderharbour_data, "S13689_PenderHarbour_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

----------------------------
  #Tofino S13855
  
tofino_data <- read.csv(
    "S13855_Tofino_2025/2S13855DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

tofino_data$'Date-Time' <- as.POSIXct(tofino_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
tofino_data$'Date-Time' <- format(tofino_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(tofino_data, "S13855_Tofino_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

--------------------------
  #Hope Bay S13775
  
hopebay_data <- read.csv(
    "S13775_HopeBay_2025/1S13775DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

hopebay_data$'Date-Time' <- as.POSIXct(hopebay_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
hopebay_data$'Date-Time' <- format(hopebay_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(hopebay_data, "S13775_HopeBay_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")

--------------------
  #Silva Bay
  
silvabay_data <- read.csv(
    "S13854_SilvaBay_2025/1S13854DAT.CSV",
    sep = ";",
    dec = ",",
    stringsAsFactors = FALSE,
    fileEncoding = "Latin1",
    check.names = FALSE
  )

silvabay_data$'Date-Time' <- as.POSIXct(silvabay_data$'Date-Time', format = "%d.%m.%Y %H:%M:%S")
silvabay_data$'Date-Time' <- format(silvabay_data$'Date-Time', "%d-%m-%Y %H:%M:%S")

write.csv(silvabay_data, "S13854_SilvaBay_REFORMATTED.csv", row.names = FALSE, fileEncoding = "Latin1")


