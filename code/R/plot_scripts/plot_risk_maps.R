
get_risk_map_data <- function(rnd, model_data, scen=NULL, ensemble=NULL) {
  
  if(is.null(ensemble)) ensemble <- get_default_ensemble_fixed(rnd)
  
  x_cum <- model_data[
    is.na(quantile)==TRUE & !is.na(value) & 
    str_detect(outcome, "Incident")==TRUE &
    model_name==ensemble
  ]
  
  x_cum <- x_cum[locations[i=!location %chin% c("US", "60","66","69", "72", "74","78"),
                          j=.(abbreviation, location_name, population, location)], on="location_name"]
  
  
  # New setup, one row for every wk
  x_cum[, Cumul:=cumsum(value*10000/population), by = .(location_name, outcome, scenario_id)]
  x_cum <- x_cum[, .(abbreviation, location, Cumul, outcome, target_end_date, target_wk, scenario_id)]
  setnames(x_cum, old="abbreviation", new="fips")
  
  # Old set up, cumulative at week 26 only
  # x_cum <- x_cum[, .("Cumul" = sum((value/population)*10000)), by=.(scenario_id, outcome, model_name, abbreviation, location)]
  # x_cum <- x_cum[, .(abbreviation, location, Cumul, outcome)]
  # setnames(x_cum, old="abbreviation", new="fips")
  
  return(x_cum[])
}

get_risk_map_data_zero <- function(rnd, zeroed_data, scen=NULL, ensemble=NULL) {
  
  if(is.null(ensemble)) ensemble <- get_default_ensemble_fixed(rnd)
  
  x_cum <- zeroed_data[
    is.na(quantile)==TRUE & !is.na(value) & model_name==ensemble
  ]
  
  x_cum <- x_cum[locations[i=!location %chin% c("US", "60","66","69", "72", "74","78"),
                           j=.(abbreviation, location_name, population, location)], on="location_name"]
  
  
  # New setup, one row for every wk
  setnames(x_cum, old="value", new="Cumul")
  x_cum[, Cumul:=(Cumul/population)*10000]
  x_cum <- x_cum[, .(abbreviation, location, Cumul, outcome, target_end_date, target_wk, scenario_id)]
  setnames(x_cum, old="abbreviation", new="fips")
  
  # Old set up, cumulative at week 26 only
  # x_cum <- x_cum[, .("Cumul" = sum((value/population)*10000)), by=.(scenario_id, outcome, model_name, abbreviation, location)]
  # x_cum <- x_cum[, .(abbreviation, location, Cumul, outcome)]
  # setnames(x_cum, old="abbreviation", new="fips")
  
  return(x_cum[])
}



create_risk_map_plot_ggplot <- function(plot_data, scen,
                                        outcome_choice = "Incident Deaths"
                                        ) {
  
  
  # Scen could be a vector of length>1, if so, we take the first one
  scen = scen[1]
  
  outcome_choice <- fifelse(
    test = str_detect(outcome_choice, "Cumulative"),
    yes =str_replace(outcome_choice, "Cumulative", "Incident"),
    no = outcome_choice)

    # set location to fips
  plot_data$fips <- NULL
  setnames(plot_data, old="location", new="fips")
  
  title = paste0("Cumulative ", str_remove(outcome_choice,"^Incident "), " per 10,000 population")
  p <- usmap::plot_usmap(
    regions = "states", 
    data = filter(plot_data, outcome == outcome_choice, scenario_id == scen) %>% select(-outcome),
    values = "Cumul"
    ) +
    theme(legend.position = "right", text=element_text(size=16)) +
    scale_fill_continuous(type="viridis", name = "Cumul per \n 10,000 pop") +
    ggtitle(title) +
    theme(plot.title = element_text(hjust = 0.5))
  
  return(p)
            
            
            
}


create_risk_map_plot_plotly <- function(plot_data, scen=NULL,
                                        outcome_choice = "Incident Deaths",
                                        colorscale="Portland", reversescale=F) {
  

  # Scen could be null?  If so, we take the first scenario in plot_data
  if(is.null(scen)) scen =  unique(plot_data$scenario_id)
 
    # Scen could be a vector of length>1, if so, we take the first one
  scen = scen[1]
  

  
  # for now, limit to week 13 and onward
  #plot_data <- plot_data[target_wk>=13]
  
  outcome_choice <- fifelse(
    test = str_detect(outcome_choice, "Cumulative"),
    yes =str_replace(outcome_choice, "Cumulative", "Incident"),
    no = outcome_choice)
  
  title = paste0("Cumulative ", str_remove(outcome_choice,"^Incident "),
                 " per 10,000 population (", scen, ")")

  # add the hover value, and make dates factors
  plot_data[, `:=`(Cumul=round(Cumul,2), Date=factor(target_end_date))]
  
  # give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = FALSE
  )
  
  color_scale_max = max(plot_data[outcome==outcome_choice & scenario_id == scen, Cumul], na.rm=T)
  
  fig <- plot_data[outcome==outcome_choice & scenario_id == scen] %>% 
    plot_geo(locationmode = 'USA-states',height=900) %>% 
    add_trace(z = ~Cumul,
              locations = ~fips,
              frame = ~Date,
              color = ~Cumul,
              colorscale = colorscale,
              
              reversescale =reversescale,
              zmin=0, zmax=color_scale_max, zauto=F
    ) %>% 
    colorbar(title = "Cumul") %>% 
    layout(
      title = title,
      geo = g
      ) %>% 
    animation_opts(redraw = F) %>% 
    animation_button(y=1.1,visible=T) %>% 
    animation_slider(y=1.1)
  
  fig
  
}

create_risk_map_zero_plotly <- function(plot_data, scen=NULL,
                                        outcome_choice = "Cumulative Deaths",
                                        colorscale="Portland", reversescale=F) {
  
  
  # Scen could be null?  If so, we take the first scenario in plot_data
  if(is.null(scen)) scen =  unique(plot_data$scenario_id)
  
  # Scen could be a vector of length>1, if so, we take the first one
  scen = scen[1]
  
  # outcome_choice <- fifelse(
  #   test = str_detect(outcome_choice, "Cumulative"),
  #   yes =str_replace(outcome_choice, "Cumulative", "Incident"),
  #   no = outcome_choice)
  
  title = paste0(outcome_choice," per 10,000 population (", scen, ")")
  
  # add the hover value, and make dates factors
  plot_data[, `:=`(Cumul=round(Cumul,2), Date=factor(target_end_date))]
  
  # give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = FALSE
  )
  
  color_scale_max = max(plot_data[outcome==outcome_choice & scenario_id == scen, Cumul], na.rm=T)
  
  fig <- plot_data[outcome==outcome_choice & scenario_id == scen] %>% 
    plot_geo(locationmode = 'USA-states',height=900) %>% 
    add_trace(z = ~Cumul,
              locations = ~fips,
              frame = ~Date,
              color = ~Cumul,
              colorscale = colorscale,
              
              reversescale =reversescale,
              zmin=0, zmax=color_scale_max, zauto=F
    ) %>% 
    colorbar(title = "Cumul") %>% 
    layout(
      title = title,
      geo = g
    ) %>% 
    animation_opts(redraw = F) %>% 
    animation_button(y=1.1,visible=T) %>% 
    animation_slider(y=1.1)
  
  fig
  
}
