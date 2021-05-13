#Summary Stats
library(tidyverse)
library(readxl)
library(gt)
library(ggplot2)
library(rstatix)

#Production analysis/summary stats

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
PI_all %>% 
  tukey_hsd(pmax ~ Site*Season) %>% 
  gt()

#Type II ANOVA - alpha by season and site
PI_all %>% 
 tukey_hsd(alpha ~Site*Season) %>% 
  gt()

#Type II ANOVA - O2 by season and site
PI_all %>% 
  tukey_hsd(O2 ~ Site*Season) %>% 
  gt()


#Correlation test of one variable (pmax vs alpha) against all
PI_all %>% 
  cor_test(alpha, method = "pearson") %>% 
  gt()




