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

library(ggplot2)
plot_airport_line <- function(df, aeroport){
  trafic_aeroport <- df %>% 
    mutate(trafic = apt_pax_dep + apt_pax_tr + apt_pax_arr) %>% 
    filter(apt %in% aeroport) %>% #ici, %in% sert de "=="
    mutate(
      date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
    )
  graph <- ggplot(trafic_aeroport) + geom_line(mapping = aes(date,trafic), color = 'red')
  return(plotly::plot_ly(trafic_aeroport, x=~trafic_aeroport$date, y=~trafic_aeroport$trafic, mode = 'lines'))
}

plot_airport_line(pax_apt_all,"FMEE" )

YEARS_LIST  <- as.character(2018:2022)
MONTHS_LIST <- 1:12

create_data_from_input <- function(df, annee, month){
  data <- df %>% filter(an %in% annee,mois %in% month)
  return(data)
}

exo4a <- create_data_from_input(pax_apt_all, YEARS_LIST[4],MONTHS_LIST[6] )
