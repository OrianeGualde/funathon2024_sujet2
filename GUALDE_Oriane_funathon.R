install.packages("yaml")
library(yaml) #au lieu de faire des librairies : yaml::[appel de la fonction]

##Exercice 1
#Importation du fichier
test <- read_yaml("sources.yml")

#Appel à la fonction présente dans le répertoire R
source("R/create_data_list.R")
urls <- create_data_list("sources.yml")

##Exercice 2
library(readr)
library(stringr)

#Nettoyage des données
source("R/clean_dataframe.R")

source("R/import_data.R")

######## Aéroports ######## 
data_aeroport <- read_csv2(unlist(urls$airports))

data_aeroport <- import_airport_data(urls$airports)

######## Compagnies ######## 
#pour voir le type des colonnes:
data_compagnies <- read_csv2(unlist(urls$compagnies))

data_compagnies <- import_airport_data(urls$compagnies)

######## Liaisons ######## 
data_liaisons <- read_csv2(unlist(urls$liaisons))

data_liaisons <- import_liaisons_data(urls$liaisons)


##Localisation des aéroports
library(sf)
airports_location <- st_read(urls$geojson$airport)
#Vérifier que les données sont bien dans le système de représentation WGS 84
test <- sf::st_crs(airports_location)$input
view(test) #bien égal à WGS 84

leaflet::leaflet(airports_location) %>% 
  leaflet::addTiles() %>%
  leaflet::addMarkers()






