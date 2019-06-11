#Mean biomass per trophic group for each BGR
rm(list=ls())
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)
library(readxl)

#get data
NACRE_Test <- read_excel("C:/Users/JEM BALDISIMO/Desktop/NACRE_Test.xlsx")
View(NACRE_Test)

#Get only used transect readings for Biomass & show results per BGR & trophic levles
NACRE_Data <- subset(NACRE_Test, NACRE_used == "yes" & trophicgroup != "no record" & trophicgroup != "#N/A",
                     select=c(BGR, Biomassmtperkm2, trophicgroup))
NACRE_Data

#create new table showing only the 3 
NACRE_Biomass <- NACRE_Data %>%
  group_by(BGR, trophicgroup) %>%
  summarise(
    Biomass = sum(Biomassmtperkm2)
  )
NACRE_Biomass

trophiclevel <- ggplot(data = NACRE_Biomass) +
  aes(x = BGR, y = Biomass, fill = as.factor(trophicgroup)) +
  geom_col() +
  theme_classic()+
  theme(axis.text.x = element_text(angle = 90,hjust = 1)) +
  labs(fill = "Trophic Groups", x = "Biogeographic Region", y = "Total Biomass (mt/km^2)")

trophiclevel 
png(filename = "trophiclevel.png")
  trophiclevel 
dev.off()
