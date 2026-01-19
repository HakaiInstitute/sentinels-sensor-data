#===============================================================================
# Sentinels Salinity Data wrangling
# combine csvs from all sites
#
# Input:
#     reformatted csvs
#
# Output:
#     single csv with all sites 
#
# Isaak Haberman (Hakai Institute) isaak.haberman@hakai.org
# First Created 01/2026
# Last Updated 01/2026
#===============================================================================



IndianArm <- read.csv("staroddi-data/2025/S13688_IndianArm_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
IndianArm$site <- "Indian Arm"

PenderHarbour <- read.csv("staroddi-data/2025/S13689_PenderHarbour_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
PenderHarbour$site <- "Pender Harbour"

QCove <- read.csv("staroddi-data/2025/S13774_QuathiaskiCove_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
QCove$site <- "Quathiaski Cove"

HopeBay <- read.csv("staroddi-data/2025/S13775_HopeBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
HopeBay$site <- "Hope Bay"

Comox <- read.csv("staroddi-data/2025/S13822_Comox_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Comox$site <- "Comox"

PortMoody <- read.csv("staroddi-data/2025/S13833_PortMoody_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
PortMoody$site <- "Port Moody"

Sooke <- read.csv("staroddi-data/2025/S13849_Sooke_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Sooke$site <- "Sooke"

Cowichan <- read.csv("staroddi-data/2025/S13850_Cowichan_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Cowichan$site <- "Cowichan"

Descanso <- read.csv("staroddi-data/2025/S13851_Descanso_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Descanso$site <- "Descanso"

FordCove <- read.csv("staroddi-data/2025/S13852_FordCove_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
FordCove$site <- "Ford Cove"

WhalerBay <- read.csv("staroddi-data/2025/S13853_WhalerBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
WhalerBay$site <- "Whaler Bay"

SilvaBay <- read.csv("staroddi-data/2025/S13854_SilvaBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
SilvaBay$site <- "Silva Bay"

Tofino <- read.csv("staroddi-data/2025/S13855_Tofino_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Tofino$site <- "Tofino"

EchoBay <- read.csv("staroddi-data/2025/S13856_EchoBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
EchoBay$site <- "Echo Bay"

PrinceRupert <- read.csv("staroddi-data/2025/S13857_PrinceRupert_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
PrinceRupert$site <- "Prince Rupert"

MinersBay <- read.csv("staroddi-data/2025/S13859_MinersBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
MinersBay$site <- "Miners Bay"

DaajingGiids <- read.csv("staroddi-data/2025/S13864_DaajingGiids_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
DaajingGiids$site <- "Daajing Giids"

Victoria <- read.csv("staroddi-data/2025/S13870_Victoria_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
Victoria$site <- "Victoria"

HorseshoeBay <- read.csv("staroddi-data/2025/S13883_HorseshoeBay_REFORMATTED.csv", fileEncoding = "latin1", check.names = FALSE)
HorseshoeBay$site <- "Horseshoe Bay"

df <- rbind(IndianArm, PenderHarbour, QCove, HopeBay, Comox, PortMoody, Sooke, Cowichan, Descanso, FordCove, WhalerBay, SilvaBay, Tofino, EchoBay, PrinceRupert, MinersBay, DaajingGiids, Victoria, HorseshoeBay)

write.csv(df, "staroddi-data/2025/combined_data.csv")
