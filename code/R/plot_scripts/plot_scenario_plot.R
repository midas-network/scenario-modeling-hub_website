# Slimmed down version of the server_plot



# Function to get y-axis for scenario plot
get_max_overall <- function(m_df, g_df, pi, target) {
  
  if(pi==0) model_max=max(m_df$point, na.rm=T)
  else model_max = max(m_df[,.(point, min,max)], na.rm=T)
  
  if(target=="Cumulative Hospitalizations") gs_max = 0
  else gs_max = max(g_df$value, na.rm=T)
  
  return(max(model_max,gs_max)*1.05)
}



get_scen_plot <- function(
  m_df, g_df,pred_date,today,mod_colors,showlegend=F,title=NULL,target=NULL,pi=TRUE, ymax=NULL) {
  
  
  # get the fixed range dates
  fixed_range_dates = c(
    min(g_df$time_value, na.rm=T),
    max(m_df$target_end_date, na.rm=T)
  )
  
  fixed_range_values=c(0,ymax)

  if(showlegend) legendgroups=c("Models","Observed")
  else legendgroups =c(NULL,NULL)
  
  fig <- plot_ly(data = m_df, 
                 x=~target_end_date, color=~model_name,
                 colors = mod_colors,legendgroup=~model_name
  ) %>% 
    #add points/lines
    add_trace(y=~point, type="scatter", mode="lines", showlegend=showlegend)
  
  # add ribbons
  if(pi) {
    fig <- fig %>% add_ribbons(data=m_df, x=~target_end_date, ymin =~min, ymax=~max,showlegend=F,opacity=0.6, connectgaps=TRUE)
  }
  
  # add empirical
  fig <- fig %>% add_trace(data=g_df,
                           x=~time_value, y=~value, type="scatter", mode="lines+markers",
                           line=list(color='grey43'), marker=list(color='grey43'),
                           showlegend=showlegend
                           
  )
  
  # Add title using annotations
  fig <- add_annotation(fig=fig, text = title, xref="paper", yref="paper",fontsize = 10)
  
  fig <- fig %>%
    layout(
      legend = list(x = 0,
                    xanchor = "left",
                    y = -0.1,
                    orientation = "h",
                    font = list(size = 10), 
                    tracegroupgap = 2, 
                    traceorder ="grouped",
                    itemwidth = 2
                    ),
      
      # add lines around plots
      xaxis = list(title=list("text"="Date","standoff"=.5), showline=T, mirror="all", linecolor="black", range = fixed_range_dates),
      yaxis = list(title=list("text"=target,"standoff"=.5), showline=T, mirror="all", linecolor="black", range = fixed_range_values),
      
      # Add vertical lines
      shapes= list(
        vline(as.Date(pred_date), style="solid", color="gray"),
        vline(as.Date(wtoday), style="dash", color="gray")
      )
    )
  
  # return the single plot
  return(fig)
}  



scenario_plot <- function(target, location, scen_sel, pi, rtab) {

  if(sum(sapply(list(target,location,scen_sel,pi,rtab), is.null))>0) {
    return(NULL)
  }
  
  r = as.integer(str_extract(rtab,"\\d+"))
  
  # First get the full data for this target, location, etc
  pl_input = prepare_plot_data(target, location, scen_sel, pi, rtab)
  
  # Second set the fixed colors for each model
  model_colors = get_model_colors(pl_input[["model_visual"]])
  
  # Set the overall ymax
  max_overall = get_max_overall(pl_input[["model_visual"]], pl_input[["gs_visual"]], pi, target)
  
  
  # Third, foreach scenario, loop through, creating the scenario specific fig
  figs = lapply(scen_sel, function(x) {
  
    # Set legend_on only if this scenario is the greatest number of models.
    legend_on = x == pl_input[["model_visual"]][, uniqueN(model_name), by=scenario_id][order(-V1),first(scenario_id)]
                        
    # Get the title of this scenario/round 
    this_title = scen_info[rnd_num==r & scenario_id == x]$scen_title

    # Get the scenario plot for each scenario
    get_scen_plot(m_df = pl_input[["model_visual"]][scenario_id == x],
                  g_df = pl_input[["gs_visual"]],
                  pred_date = pl_input[["pred_date"]],
                  today = wtoday,
                  mod_colors = model_colors,
                  showlegend = legend_on, 
                  title=this_title,
                  target=target,
                  pi=(pi!=0),
                  ymax=max_overall)
  })
  
  p <- get_subplot(figs, r, target)
  
  # set all model traces to be initially off (legendonly)
  
  p <- set_model_traces_off(p)
  
  p <- p %>% 
    layout(updatemenus=get_menu(p)) %>%
    config(displaylogo = TRUE, modeBarButtonsToRemove = c("lasso2d", "select2d", "toImage", "drawrect"))
           
  return(p)
}

set_model_traces_off <- function(p) {
  for(i in seq(1,length(p$x$data))) {
    tname = p$x$data[[i]]$name
    if(str_detect(tname, "Ensemble|Observed")) {
      p$x$data[[i]]$visible = TRUE
    } else {
      p$x$data[[i]]$visible = "legendonly"
    }
       
  }
  return(p)
}

get_menu <- function(p) {
  times = length(p$x$data)
  
  updatemenu <- list(
    list(y = 1,
         x = 1.01,
         xanchor = "left",
         type = "buttons",
         active = 0,
         buttons = c(
           list(
             list(
               method = "restyle",
               args = list(
                 "visible",
                 ifelse(grepl("Ensemble|Observed", map(p$x$data, "name")),TRUE, "legendonly")
                 ),
               label = "Ensemble")
             ),
           list(
             list(
               method = "restyle",
               args = list("visible", rep(TRUE, times)),
               label = "All")
             )
           )
         )
    )
  
  return(updatemenu)
}

get_subplot <- function(figs, r, target) {
  
  
  
  # Number of rows will be 2, unless 1 or 3 figures
  nrows = fifelse(length(figs) %in% c(1,3), length(figs) ,2)
  
  # if (r > 4) {
  #   view_def <- "-Ensemble_LOP$|-Ensemble_LOP,|^$"
  # } else {
  #   view_def <- "-Ensemble$|-Ensemble,|^$"
  # }
  # 
  
  # Create subplot
  p = subplot(figs, nrows=nrows, shareX = T, shareY = T, margin=c(.01,.01,.01,.05)) %>% 
    layout(
      title=list(
        text = paste0("Projected ", target, " by Epidemiological Week and Scenario (",
                      "Round ", r,")"),
        xref = "container", yref="container", x=0, y=1, xanchor="left",
        pad =list(b=50)
      ),
      margin = list(l = 10, r = 10, b = 0, t = 40),
      autosize = TRUE,
      uirevision = TRUE,
      height=900,
      annotations = list(
        text = paste0("<b>Double-click on a model name to only display it. Click on a model name to remove it or add it from the plot display. ",
                      "Zoom in the graph by click and drag (double-click to zoom-out)</b>"),
        xref="paper", yref="paper", x=0, y=-0.1,showarrow=F,align="left", xanchor="left",
        font = list(size = 10))
    )
  
  return(p)
  
}
