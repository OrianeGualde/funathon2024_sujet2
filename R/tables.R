create_table_airports <- function(df){
  sans_apt <- df %>% select(-starts_with("apt"))
  sans_apt_gt <- gt(sans_apt)
  sans_apt_gt <- sans_apt_gt %>% 
    fmt_number() %>% 
    fmt_markdown(columns = "name_clean") %>%
    cols_label(
      name_clean = md("**Aéroport**"), #pour mettre en gras
      total_pass_dep = md("**Départs**"),
      total_pass_arr = md("**Arrivée**"),
      total_pass_tra = md("**Transit**")
    ) %>%
    tab_header(
      title = md("**Statistiques de fréquentation**"),
      subtitle = md("Classement des aéroports")
    ) %>%
    tab_style(
      style = cell_fill(color = "powderblue"),
      locations = cells_title()
    ) %>%
    tab_source_note(source_note = md("_Source: DGAC, à partir des données sur data.gouv.fr_")) %>% 
    opt_interactive()
  return(sans_apt_gt)
}
