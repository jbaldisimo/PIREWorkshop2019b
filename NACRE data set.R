#Mean biomass per trophic group for each BGR
rm(list =ls())
library(tidyverse)
library(readxl)

#get data
NACRE_Test <- read_excel("C:/Users/JEM BALDISIMO/Desktop/NACRE_Test.xlsx")
View(NACRE_Test)

#Get only used transect readings for Biomass & show results per BGR & trophic levles
NACRE_Data <- subset(NACRE_Test, NACRE_used == "yes",
                     select=c(BGR, Biomassmtperkm2, trophicgroup))
NACRE_Data

#create new table showing only the 3 
NACRE_Biomass <- NACRE_Data %>%
  group_by(BGR, trophicgroup) %>%
  summarise(
    Biomass = sum(Biomassmtperkm2)
  )
NACRE_Biomass

ggplot(data = NACRE_Biomass) +
         aes(x = BGR, y = Biomass, fill = as.factor(trophicgroup)) +
  geom_col() +
  theme_classic()

