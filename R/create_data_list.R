#Création d'une fonction pour importer
create_data_list <- function(source_file){
  data <- yaml::read_yaml(source_file)
  return(data)
}
