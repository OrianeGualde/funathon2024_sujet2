create_data_from_input <- function(df, annee, month){
  data <- df %>% filter(an %in% annee,mois %in% month)
  return(data)
}


summary_stats_aeroports <- function(df){
  stats_aeroports <- df %>% 
    group_by(apt,apt_nom) %>% 
    summarise(total_pass_dep = sum(apt_pax_dep), total_pass_arr = sum(apt_pax_arr), total_pass_tra = sum(apt_pax_tr), total_pass_tot = sum(apt_pax_dep) + sum(apt_pax_arr) + sum(apt_pax_tr)) %>% 
    arrange(desc(total_pass_tot)) %>% 
    ungroup()
  return(stats_aeroports)
}


summary_stat_liaisons <- function(data){
  agg_data <- data %>%
    group_by(lsn_fsc) %>%
    summarise(
      paxloc = round(sum(lsn_pax_loc, na.rm = TRUE)*1e-6,3)
    ) %>%
    ungroup()
  return(agg_data)
}