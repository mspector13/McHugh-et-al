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

