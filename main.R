source("R/create_data_list.R")
source("R/import_data.R")  
source("R/clean_dataframe.R")

library(readr)
library(dplyr)
library(stringr)
library(sf)

MONTHS_LIST = 1:12

# Load data ----------------------------------
urls <- create_data_list("sources.yml")


pax_apt_all <- import_airport_data(unlist(urls$airports))
pax_cie_all <- import_compagnies_data(unlist(urls$compagnies))
pax_lsn_all <- import_liaisons_data(unlist(urls$liaisons))

airports_location <- st_read(urls$geojson$airport)

liste_aeroports <- unique(pax_apt_all$apt)
default_airport <- liste_aeroports[1]


trafic_aeroport <- pax_apt_all %>% 
  mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
  filter(apt %in% default_airport) %>% #ici, %in% sert de "=="
  mutate(
    date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
  )


library(ggplot2)
graph <- ggplot(trafic_aeroport) + geom_line(mapping = aes(date,trafic), color = 'red')


plotly::plot_ly(trafic_aeroport, x=~trafic_aeroport$date, y=~trafic_aeroport$trafic, mode = 'lines')
