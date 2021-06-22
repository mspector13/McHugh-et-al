#Summary Stats
library(tidyverse)
library(readxl)
library(gt)
library(tidyverse)
library(rstatix)
library(here)


# #Production analysis/summary stats --------------------------------------

PI_all <- read_xlsx("PI_all.xlsx") %>% 
  filter(Species != 'Acrosorium venulosum on Articulated Cor.')

view(PI_all)

#Point Loma
PI_all %>%
  filter(Site == 'Point Loma') %>% 
  group_by(Season,
           Year,
           Species,
           Site) %>% 
  get_summary_stats(pmax, 
                    type = "mean_sd") %>% 
  arrange(Year) %>%
  arrange(desc(Site)) %>% 
  gt() %>% 
    tab_header(
      title = "Point Loma")

#Carmel Bay
PI_all %>%
  filter(Site == 'Carmel Bay') %>% 
  group_by(Season,
           Year,
           Species,
           Site) %>% 
  get_summary_stats(pmax, 
                    type = "mean_sd") %>% 
  arrange(Year) %>%
  arrange(desc(Site)) %>% 
  gt() %>% 
  tab_header(
    title = "Carmel Bay")

#Type II ANOVA - pmax by season and site
pmax_aov <- aov(data = PI_all,
                pmax~Site*Season*Species)
summary(pmax_aov)

#Type II ANOVA - alpha by season and site
alpha_aov <- aov(data = PI_all,
                alpha~Site*Season*Species)
summary(alpha_aov)



# Community responses ------------------------------------------------------

PL_data <- read_csv(here::here("Community_data", "Comm_data_PL.csv")) %>% 
  separate(SEASON, c("SEASON", "YEAR"), " ") %>% 
  filter(YEAR == c(2016, 2017))

#This shows that there is not clear pattern; no single species is driving the system
#NO clear evidence for light adaption
#Spatial and temporal variation drives the system 

PL_data %>% 
  filter(YEAR == c(2016, 2017)) %>% 
  ggplot(aes(x = TREATMENT,
             y = ABUNDANCE, 
             group = SEASON))+
  geom_bar(stat="identity",
           aes(fill=SEASON),
           position = position_dodge(width = 0.9))+
  facet_grid(SPECIES ~ YEAR)

facet_wrap(~SPECIES)

#helpful?
no_zero <- PL_comm %>% 
  # filter out sites with 0 observations
  mutate(sum = rowSums(across(where(is.numeric)))) %>% 
  filter(sum > 0) %>% 
  select(-sum) 

CMB_data <- read_csv(here::here("Community_data", "Comm_data_CMB.csv")) %>% 
  separate(SEASON, c("SEASON", "YEAR"), " ") %>% 
  filter(YEAR == c(2016, 2017))

CMB_data %>% 
  filter(YEAR == c(2016, 2017)) %>% 
  ggplot(aes(x = TREATMENT,
             y = ABUNDANCE, 
             group = SEASON))+
  geom_bar(stat="identity",
           aes(fill=SEASON),
           position = position_dodge(width = 0.9))+
  facet_grid(SPECIES ~ YEAR)

