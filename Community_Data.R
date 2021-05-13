#Community data

library(tidyverse)
library(readxl)

PL_dataz <- read_csv("PL_data.csv") %>% 
  separate(SEASON, c("SEASON", "YEAR"), " ") %>% 
  FIGUREOUTHOWTODROP2015

view(PL_dataz)


TRIS_LOOK_HERE <- ggplot(PL_dataz[which(PL_dataz$YEAR != "2015"),]) + 
  geom_bar(aes(x = TREATMENT, y = ABUNDANCE, color = SPECIES), 
           position="stack", stat="identity") +
  facet_wrap(vars(SEASON))

TRIS_LOOK_HERE

CM_dataz <- read_csv("CM_data.csv") %>% 
  separate(SEASON, c("SEASON", "YEAR"), " ")

view(CM_data)

