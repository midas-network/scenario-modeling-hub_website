# Generate state level variation in week 13 and week 26 incidence rates

get_variation_data <- function(rnd, model_data) {
  subset <- model_data[
    (
        is.na(quantile)==TRUE &
        !location_name %in% c("American Samoa", "Virgin Islands", "Guam", "Northern Mariana Islands", "Puerto Rico")
    )      
    ]
  subset[,model_type:=fifelse(str_detect(model_name, "Ensemble"),"Ensemble", "Individual")]
  
  # drop any non_default ensemble (we only want one)
  subset <- subset[model_type=="Individual" | (model_type=="Ensemble" & model_name == get_default_ensemble_fixed(rnd))]
  
  
  # get the population data
  subset <- locations[,.(location_name,population)][subset, on="location_name"]
  
  # add the scenario titles
  
  subset <- subset[scen_info[rnd_num==rnd, .(scenario_id, scen_title)], on="scenario_id"]
  
  # for earlier versions of R - lets see if changing model_name to character works
  subset[, model_name:=as.character(model_name)]
  
  return(subset)
  
  
}

create_state_variation_plot <- function(state_variation_data = NULL, outcome_choice="Incident Cases", wk = 1, make_plotly=FALSE) {
  
  p <- ggplot() +
    geom_point(data = state_variation_data[outcome == outcome_choice & target_wk==wk],
               aes(x = value/population * 100000, y = factor(location_name), 
                   color = model_name, size = model_type, alpha = model_type)) +
    scale_alpha_manual(values = c(1, 0.5)) +
    scale_size_manual(values = c(3.5, 2)) +
    #scale_color_manual(values = model_colors) +
    xlab(paste0("Week ", wk, " incidence per 100,000 population")) +
    ylab("") +
    #facet_wrap(~scenario_name,labeller = labeller(scenario_name = scenario_labs), nrow = 4) +
    facet_wrap(~scen_title,nrow=4) +
    scale_x_sqrt(labels = scales::comma) +
    ggtitle(paste0("State variation in week ",wk," incidence rate - ", outcome_choice)) +
    guides(size = "none", alpha = "none",
           color = guide_legend(override.aes = list(size = 5))
           )+
    theme_bw() +
    theme(plot.title = element_text(hjust = 0.5),
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
          legend.title = element_blank(), legend.position="bottom", 
          text = element_text(size=24)) +
    coord_flip()
  
  if(make_plotly) {
    p <- plotly::ggplotly(p)
  }
  
  return(p)
  
  
}


create_state_variation_plotly <- function(
  state_variation_data = NULL,
  scen=NULL,
  scale_type = "linear",
  outcome_choice="Incident Cases" ) {
  
  # Scen could be null?  If so, we take the first scenario in plot_data
  if(is.null(scen)) scen =  unique(state_variation_data$scenario_id)
  
  # Scen could be a vector of length>1, if so, we take the first one
  scen = scen[1]
  
  
  state_variation_data[,Date:=factor(target_end_date)]
  model_colors = get_model_colors(state_variation_data)

  fig<- plot_ly(state_variation_data[outcome==outcome_choice & scenario_id == scen],
                y = ~value*100000/population, x =~location_name,
                color = ~model_name, 
                colors = model_colors,
                type = "scatter", mode="markers", frame=~Date,
                height=900) %>%
    layout(
      title=list(
          text=paste0(
            "State Variation in ",
            outcome_choice,
            " per 100,000 population (From Projection Wk 1 to 26, ",
            scen,
            ")"),
          xref = "container", yref="container", x=0, y=1.10, xanchor="left"
      ),
      legend=list(orientation="v"),
           xaxis = list(title="", tickfont = list(size=9)),
           yaxis = list(type=scale_type, tickfont = list(size=8), 
                        title=paste0(outcome_choice," per 100K pop"),
                        autorange=TRUE
           )
    ) %>% 
    animation_button(pad=list(t=100)) %>% 
    animation_slider(pad=list(t=100))


  return(fig)


}

