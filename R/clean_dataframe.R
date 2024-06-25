clean_dataframe <- function(df){
  an <- substr(df$ANMOIS, 1, 4)
  mois <- str_remove(substr(df$ANMOIS, 5,6),"^0+")
  #Mettre les majuscules en minuscules
  colnames(df) <- tolower(colnames(df))
  return(df)
}