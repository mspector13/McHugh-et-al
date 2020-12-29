# McHugh-et-al
Repo for P vs I data for McHugh et al. 

Contained in this repo are the (P)hotosynthesis vs (I)rradiance data collected per species (3x replicatates / species) per site (Carmel Bay in the north, Point Loma in the south). 

These raw data have been collated into master workbooks for each time period within each site (e.g. Carmel Bay - Summer 2017 denoted as CB_SU17.xlsx). 

Each sheet (e.g. species) is then run through a fit equation in `model.R` (adapted by Dr. Luke Miller for Spector and Edwards 2020) to obtain alpha (slope) and Pmax (top of slope equation). 

Note: this is an adaption of the work done by Webb et al. 1974 who did similar P vs I equations on pine needles. Because the light levels were smaller for this experiment (like Spector and Edwards 2020) a special model had to be created.

Once alpha and Pmax are identified, the equation: O2 = a*(PAR)^b  can be used to identify production values (O2) at a given light level (PAR) / species
