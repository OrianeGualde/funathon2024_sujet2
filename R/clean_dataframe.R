clean_dataframe <- function(df){
  df$an <- str_sub(df$ANMOIS, 1, 4)
  df$mois <- str_remove(str_sub(df$ANMOIS, 5,6),"^0+")
  #Mettre les majuscules en minuscules
  colnames(df) <- tolower(colnames(df))
  return(df)
}

