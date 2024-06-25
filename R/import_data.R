import_airport_data <- function(list_files){
  df <- read_csv2(unlist(list_files), 
                  col_types = cols(
                    ANMOIS = col_character(),
                    APT = col_character(),
                    APT_NOM = col_character(),
                    APT_ZON = col_character(),
                    .default = col_double()
                  )) 
  df <- clean_dataframe(df)
  return(df)
}

import_compagnies_data <- function(list_files){
  df <- read_csv2(unlist(list_files), 
                  col_types = cols(
                    ANMOIS = col_character(),
                    CIE = col_character(),
                    CIE_NOM = col_character(),
                    CIE_NAT = col_character(),
                    #CIE_PAYS variables numériques : par défaut on est bien en numérique
                    #CIE_PAX
                    #CIE_FRP
                    #CIE_PKT 
                    #CIE_TKT 
                    #CIE_PEQT 
                    #CIE_VOL 
                    .default = col_double()
                  )) 
  df <- clean_dataframe(df)
  return(df)
}

import_liaisons_data <- function(list_files){
  df <- read_csv2(unlist(list_files), 
                  col_types = cols(
                    ANMOIS = col_character(),
                    LSN = col_character(),
                    LSN_DEP_NOM = col_character(),
                    LSN_ARR_NOM = col_character(),
                    LSN_SCT = col_character(),
                    LSN_FSC = col_character(),
                    .default = col_double()
                  )) 
  df <- clean_dataframe(df)
  return(df)
}