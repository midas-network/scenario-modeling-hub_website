# Generate state level variation in week 13 and week 26 incidence rates

get_peak_period_data <- function(rnd, model_data,omicron_wave_start = "2021-12-25", aggfunc=mean) {

  peak_wk <- model_data %>%
    .[str_detect(outcome, "Incident") &
        quantile==0.5 &
        !location_name %in% c("American Samoa", "Virgin Islands", "Guam", "Northern Mariana Islands", "Puerto Rico") &
        !str_detect(model_name, "Ensemble")] %>% 
    
    # get the peak week
    .[order(scenario_id, model_name, outcome,location_name, -value, target_end_date),
      .SD[1], by=.(scenario_id, model_name, outcome, location_name)] %>% 
  
   
    # get the aggfunc peak over the models (for each target, scenario, location)
    .[,mean_peak:=aggfunc(target_end_date), .(outcome, location_name,scenario_id)]
  
  
  # add in abbreviation
  
  peak_wk <- peak_wk[locations[, .(location_name, abbreviation)], on=.(location_name), nomatch=0]
  
  # we only need current date for one row per location/outcome
  # in fact we only need this if we want to later utilize this data to somehow
  # show the observed data. As of January 26/2022, we are  not using the
  # observed data at all.
  # peak_wk[, current_date:=c(current_date[1], rep(NA,.N-1)), by=.(scenario_id, outcome,location_name)]

  return(peak_wk[])
  
}

create_peak_plot <- function(peak_data, 
                             scen_sel,
                             outcomes = c("Incident Cases", "Incident Hospitalizations"),
                             make_plotly=FALSE){
  
  gginput <- peak_data[scenario_id %in% scen_sel & outcome %chin% outcomes] %>%
    # add simple factor of senario and outcome
    .[,grp:=factor(paste(scenario_id, outcome, sep = " - "))] %>% 
    # add yval (ordering factor)
    .[,yval:=reorder(paste(abbreviation, grp, sep="___"),as.double(mean_peak),FUN=mean)]
  
  
  # return NULL if gginput is empty (this is possible in the contect of scen_sel being ""
  # because of user de-selection)
  if(nrow(gginput)==0) return(NULL)
    
    #  start plot definition
  p <- ggplot(
    data = gginput, 
    aes(x = target_end_date, y = yval, color = scenario_id,text=paste(abbreviation,":",target_end_date))) +
    
    # hack to make own grid lines
    geom_hline(yintercept = seq(5,length(unique(peak_data$abbreviation)), 10), 
               color = "grey", size = 0.4, alpha = 0.4)+
    geom_vline(xintercept = seq(range(peak_data$target_end_date)[1], range(peak_data$target_end_date)[2],14), 
               color = "grey", size = 0.4, alpha = 0.4)+
    geom_point(alpha = 0.5, size=2.5, aes(shape = "Individual Model") ) + 
    geom_point(aes(x = mean_peak,shape = "Mean Across Models"), size=2.5) + 
    
    labs(x = "Week of peak in median projection (2022)", shape="", color="") +
    facet_wrap(vars(grp), scales = "free_y",nrow = length(scen_sel)) + 
    scale_x_date(breaks = seq(range(gginput$target_end_date)[1], range(gginput$target_end_date)[2],7),
                 date_labels = "%b %d") +
    # now set the labels of the y-axis to be the yval, removing the underscores and everything after
    scale_y_discrete(labels=function(x) gsub(paste0("___",".+$"),"",x)) + 
    scale_shape_manual(values=c("Individual Model"=1, "Mean Across Models"=15)) + 
    guides(color="none") +
    theme_bw() + 
    theme(axis.title.y = element_blank(),
          legend.position = "bottom", 
          panel.grid = element_blank()) + 
    ggtitle("Week of model projection peak, by state")
  
  if(make_plotly) {
    p <- plotly::ggplotly(
      p,
      tooltip = "text",
      height = 1500) %>% 
      layout(legend=list(orientation="h"))
  }
  
  return(p)
  
  
}

##########################################################################33
# STAND ALONE PLOTLY VERSION
##########################################################################33

create_peak_plotly <- function(peak_data, 
                               scen_sel,
                               outcomes = c("Incident Cases", "Incident Hospitalizations")) {
  
  # Subset the peak data given the scen_selection and the outcome
  gginput <- peak_data[scenario_id %in% scen_sel & outcome %chin% outcomes]

  # return NULL if gginput is empty (this is possible in the contect of scen_sel being ""
  # because of user de-selection)
  if(nrow(gginput)==0) return(NULL)
  
  # Now we make the subplots, for each combination of scen_sel and outcomes
  
  # First get universal tickvalues
  tickvals = seq(range(gginput$target_end_date)[1], range(gginput$target_end_date)[2],7)
  
  # Second, get universal model colors (base it on peak data, so that it doesn't change
  # even if the scenario or outcomes change)
  mod_colors = get_model_colors(peak_data)
  
  colors = c("A" = "red", "B"="blue","C"="green", "D"="purple")
  pp_subplots = lapply(seq_along(outcomes), function(ou) {

    lapply(seq_along(scen_sel), function(ss) {
      # get the color for this scenario
      ss_color = as.character(colors[stringr::str_sub(scen_sel[ss],1,1)])
      
      # get the subplot for this scenario and outcome
      fig = single_peak_plot(
        data=gginput[scenario_id==scen_sel[ss] & outcome==outcomes[ou]],
        tickvals = tickvals,
        color = ss_color,
        mod_colors = mod_colors,
        show_legend = ss==1 & ou == 1
      )
      
      return(fig)
      
    })
    
  })
  
  pp_subplots = unlist(pp_subplots, recursive = F)
  
  fig <- plotly::subplot(pp_subplots, nrows=length(outcomes)) %>% 
    layout(
      height=1500,
      title=list(text = "Week of model projection peak, by state")
      )
  
  return(fig)
  
}
  

single_peak_plot <- function(data, tickvals, color, mod_colors,show_legend=TRUE) {
  
  
  title = paste(unique(data$scenario_id), "-", unique(data$outcome))
  
  # add the grp and ordering factor
  data[,yval:=reorder(abbreviation,as.double(mean_peak),FUN=mean)]
  
  # reduce the mod_colors to only ones currently in data
  mod_colors[as.character(data[, unique(model_name)])]
  mods = names(mod_colors)
  
  first_model = mods[1]
  
  p <- plot_ly(
    data = data[model_name==first_model],
    y=~yval,
    x=~target_end_date,
    type="scatter",
    mode="markers",
    marker=list(symbol="circle", color=mod_colors[first_model], opacity=0.7,size=10),
    legendgroup = first_model,
    name=first_model,
    showlegend=show_legend
  )
  
   
  for(mod in names(mod_colors)[-1]) {
    if(nrow(data[model_name==mod])>0) {
      p <- p %>%
        add_trace(
          data = data[model_name==mod],
                  y=~yval,
                  x=~target_end_date,
                  marker=list(symbol="circle", color=mod_colors[mod], opacity=0.7,size=10),
                  legendgroup = mod,
                  name=mod,
                  showlegend=show_legend
        )
    }
  }
  
  agg_data = data[, !c("value","model_name","target_end_date","target_wk")] %>% unique()
  
   
  # add a "fake" marker behind one of the agg data points, with black color
  p <- p %>% 
    add_markers(
      data=agg_data[1],
      x=~mean_peak,
      y=~yval,
      marker=list(
        color="black",
        symbol="square",
        opacity=1,
        size=10
      ),
      name="Mean Across Models",
      legendgroup="leg_grp_indiv",
      showlegend=show_legend
    )
  
  p <- p %>% 
    add_trace(
      data=agg_data,
      x=~mean_peak,
      y=~yval,
      marker=list(
        color=color,
        symbol="square",
        opacity=1,
        size=10
      ),
      name="Mean Across Models",
      legendgroup="leg_grp_indiv",
      showlegend=F
    ) 
  
  
    
    
  
  
  p <- p %>%
    layout(
      annotations = list(
        text=title,x=.1, y=1, xanchor= "left", xref='paper', yref='paper',showarrow=F
      ),
      yaxis=list(
        title=list(text=""),
        dtick=1),
      xaxis=list(
        title=list(text=""),
        tickvals = tickvals,
        tickformat = "%b %d",
        tickfont = list(size = 10),
        range = c(tickvals[1]-2, tickvals[length(tickvals)]+2),
        tickangle = 45,
        fixedrange=TRUE
      ),
      legend = list(orientation='h')
    )
  
  return(p)
}

