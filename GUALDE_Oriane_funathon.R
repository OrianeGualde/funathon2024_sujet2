install.packages("yaml")
library(yaml)

#Importation du fichier
test <- read_yaml("sources.yml")

#Appel à la fonction présente dans le répertoire R
source("R/create_data_list.R")
data <- create_data_list("sources.yml")
