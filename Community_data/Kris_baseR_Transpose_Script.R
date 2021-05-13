library(tidyverse)
library(readxl)

# PL_Community -----------------------------------------------------------------

#Read in data, as a tibble
whateveryouwant <- read_xls("McHugh_Point Loma Data.xls")

#convert to a dataframe, because bas R
whateveryouwant <- as.data.frame(whateveryouwant)


#Overide the orignal date by creating a new column called "SITE_DAY"
#In this new column, assign a unique numeric identifier to each "sampling day", which is a product of the "sampling order"
#Make an identifier for sampling effort.... eventually
#This is not actually necessary to "tranpose" data, but it *may* be helpful down the line
whateveryouwant <- cbind(c(1, cumsum(diff(match(whateveryouwant$SITE, unique(whateveryouwant$SITE))) != 0)+1), whateveryouwant)
names(whateveryouwant)[1] <- "SITE_DAY"

#Here is where the magic happens
#Make a blank data.frame and store it in a vector ("PL_data")
PL_data <- data.frame()

#ANNOTATE THIS WHEN IT MAKES SENSE. ASSHOLE
for (cs in c(7:19)){
  df.temp <- cbind(whateveryouwant[,c(1:6)], names(whateveryouwant)[cs], whateveryouwant[,cs])
  names(df.temp) <- c(names(whateveryouwant)[c(1:6)], "SPECIES", "ABUNDANCE")
  PL_data <- rbind(PL_data, df.temp)
}

head(PL_data)

write.csv(PL_data, "PL_data.csv", row.names = F)

# CM_Community###ERRORS ------------------------------------------------------------

CM_Comm <- read_xls("McHugh_Carmel Bay Data.xls") %>% 
  as.data.frame()
CM_Comm

CM_Comm <- cbind(c(1, cumsum(diff(match(CM_Comm$SITE, unique(CM_Comm$SITE))) != 0)+1), CM_Comm)
names(CM_Comm)[1] <- "SITE_DAY"

#Here is where the magic happens
#Make a blank data.frame and store it in a vector ("CM_data")
CM_data <- data.frame()

#ANNOTATE THIS WHEN IT MAKES SENSE. ASSHOLE
for (cs in c(2:45)){
  df.temp <- cbind(CM_Comm[,c(1:6)], names(CM_Comm)[cs], CM_Comm[,cs])
  names(df.temp) <- c(names(CM_Comm)[c(1:6)], "SPECIES", "ABUNDANCE")
  CM_data <- rbind(CM_data, df.temp)
}

head(CM_data)

write.csv(CM_data, "CM_data.csv", row.names = F)
