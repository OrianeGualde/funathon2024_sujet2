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


#Exercice 4a: préparer les données avant de faire un beau tableau 
source("R/divers_function.R")
exo4a <- create_data_from_input(pax_apt_all, YEARS_LIST[4],MONTHS_LIST[6] )

library(plotly)
library(dyplr)

stats_aeroports <- summary_stats_aeroports(pax_apt_all)

#ajout d'une colonne supplémentaire pour une plus beau tableau
stats_aeroports_table <- stats_aeroports %>%
  mutate(name_clean = paste0(str_to_sentence(apt_nom), " _(", apt, ")_")
  ) %>%
  select(name_clean, everything())

#Exercice 4b:
library(gt)
source("R/tables.R")
table_aeroports <- create_table_airports(stats_aeroports_table)
table_aeroports

#Exercice 5:
month <- 1
year <- 2019
palette <- c("green", "blue", "red")


trafic_date <- pax_apt_all %>% 
  mutate(
    date = as.Date(paste(anmois, "01", sep=""), format = "%Y%m%d")
  ) %>%
  filter(mois == month, an == year)

trafic_aeroports_left <- airports_location %>% 
  left_join(trafic_date, by = c("Code.OACI" = "apt" )) 
#On a une ligne en + MAIS elle n'a que des valeurs NA pour toutes les colonnes venant de y.
#Un left join gardera TOUTES ses lignes et prendra les valeurs de y si'il elles existent

trafic_aeroports <- airports_location %>% 
  inner_join(trafic_date, by = c("Code.OACI" = "apt" ))

library(sf)
leaflet::leaflet(trafic_aeroports) %>% 
  leaflet::addTiles() %>%
  leaflet::addMarkers(popup = ~paste0(Nom, ": ", trafic)) 

