# Function to get the quasi map data
get_quasi_map_data <- function(rnd_num, 
                               model_data, 
                               model_to_show=NULL,
                               forward=6
                               ) {
  
  # we need both gold standard data and model _data
  # First model data, only ensemble
  if(is.null(model_to_show)) {
    model_to_show = fifelse(rnd_num>=5, "Ensemble_LOP", "Ensemble")
  }
  
  m_df <- model_data[
    location_name!="US" &
      str_starts(outcome, "Incident") &
      model_name == model_to_show & 
      #target_wk<=forward & ## removing this; later we will keep projection data to no more than 4 weeks beyond
      (is.na(quantile)==TRUE | (near(quantile,0.025)==TRUE | near(quantile, 0.975)==TRUE))
  ]
  
  # Note, if model_to_show does not exist in the data, then m_df will now be an empty table
  if(nrow(m_df)==0) {
    return(NULL)
  }
  
  m_df[, est:=fcase(
    is.na(quantile), "value",
    near(quantile,0.025), "lower",
    near(quantile,0.975), "upper"
  )]
  
  m_df <- m_df[locations[,.(location_name, population)], on="location_name", nomatch=0]
  
  setnames(m_df, old=c("target_end_date"), new="Date")
  
  # swing wide
  m_df <- dcast(m_df,scenario_id+outcome+Date+location_name+population~est, value.var="value")
  
  m_df[, `:=`(lower=lower*100000/population,
              upper=upper*100000/population,
              value=value*100000/population)]
  
  m_df <- m_df[, .(scenario_id, outcome, location_name, Date, value, lower, upper)]
  
  max_model_date = m_df[,max(Date)]
  
  # construct the gold standard data
  g_df <- rbindlist(gs_data, idcol = "outcome")[
    str_starts(outcome, "Incident")][
      locations[,.(location_name, population)],
      on=.(geo_value_fullname = location_name),
      nomatch=0]
  
  # make the names similar,and set the rate
  setnames(g_df, old=c("time_value", "geo_value_fullname"), new=c("Date", "location_name"))
  g_df[, value:=value*100000/population]
  
  # reduce it so that it is only the past `past' wks`
  g_df <- g_df[Date>=(min(m_df$Date)-21), .(outcome, location_name, Date, value)]
  
  max_gold_date = g_df[,max(Date)]
  
  # Here we should reduce the date of the projection if it goes more than 
  
  if(max_gold_date>=max_model_date) {
    # reduce some of the gold standard data
    g_df <- g_df[Date<=max_model_date]
  } else {
    # (possibly reduce some of the projection data)
    m_df <- m_df[Date<=(max_gold_date+(forward*7))]
  }
  
  
  
  gginput <- rbindlist(
    list("Projection" = m_df, "Observed" = g_df),
    idcol = "src", use.names = TRUE, fill=TRUE
  )

  # add the state geo colum, but update "District of Columbia to Washinging DC
  gginput[location_name=="District of Columbia", location_name:="Washington DC"]
  gginput[,state.geo := get_state_geo_factor(location_name)]
  gginput <- gginput[!is.na(state.geo)]
  
  
  return(gginput)
  
}

# This function converts a vector of location_names into a customized
# factor that allows for placing the states in quasi-geo order

get_state_geo_factor <- function(statecol) {
  # make 49 additional blank labels (each with a different length!), total will be 55+49 = 104
  bl= sapply(1:49, function(n) paste(rep(" ",n),collapse=""))
  
  # make a new variable (or could replace the old one), which is a factor variable
  # for state, and takes a mapping of the above labels, which puts them in order
  # note that the names in the mapping, must matche exactly with the names in the
  # states above; notice that I am inserting blanks (each of different size) into the 
  # row/col spots that will be blank in the 8 row by 13 column matrix
  state.geo=factor(statecol,
                   levels = c("Alaska", bl[1:11], "Maine",
                              "Northern Mariana Islands", bl[12:21], "Vermont", "New Hampshire",
                              "Guam", bl[22], "Washington", "Idaho", "Montana", "North Dakota", "Minnesota", "Illinois", "Wisconsin", "Michigan", "New York", "Rhode Island", "Massachusetts",
                              "Hawaii", bl[23], "Oregon", "Utah", "Wyoming", "South Dakota", "Iowa", "Indiana", "Ohio", "Pennsylvania", "New Jersey", "Connecticut", bl[24],
                              bl[25:26], "California", "Nevada", "Colorado", "Nebraska", "Missouri", "Kentucky", "West Virginia", "Virginia", "Maryland", "Delaware",bl[27],
                              bl[28:30], "Arizona", "New Mexico", "Kansas", "Arkansas", "Tennessee", "North Carolina", "South Carolina", "Washington DC",bl[31:32],
                              bl[33:37], "Oklahoma", "Louisiana", "Mississippi", "Alabama", "Georgia",bl[38:39],"Virgin Islands",
                              bl[40:44], "Texas",bl[45:48],"Florida", bl[49], "Puerto Rico"))
  
  return(state.geo)
}




#gginput <- gginput[abbreviation %chin% c("AS", "GU", "MP", "PR", "VI")]


create_quasi_map <- function(quasi_map_data, scenario=NULL, target_outcome="Incident Cases") {
  
  # reduce the quasi map data to the scenario and target_outcome
  gginput <- quasi_map_data[outcome ==target_outcome & (is.na(scenario_id) | scenario_id == scenario)]
  
  # Get the min max dates
  min_max_dates = c(gginput[, min(Date)], gginput[, max(Date)])
  
  # make the ggplot
  p <- ggplot(data=gginput)+
    geom_line(data=gginput[src=="Projection"], aes(x=Date,y=value, color="Projection"), size=1) + 
    geom_point(data=gginput[src=="Observed"], aes(x=Date, y=value, color="Observed"), size=1) +
    geom_ribbon(data=gginput[src=="Projection"], aes(x=Date, ymin=lower, ymax=upper, fill="Projection"), alpha=0.4) + 
    scale_color_manual(values=c("Projection" = "red", "Observed"="blue")) +
    #facet_wrap(~abbreviation, scales="free_y")
    facet_wrap(~state.geo, ncol=13, drop=F, scales="free", strip.position="top") + 
    theme_classic() + 
    theme(axis.text.x = element_blank(),
          legend.position="bottom",
          axis.text.y = element_text(size=4),
          strip.background=element_blank(),
          strip.text = element_text(face="bold", size=7),
          axis.line=element_blank(),
          axis.ticks=element_blank(),
          panel.spacing.x=unit(0.1, "lines"),panel.spacing.y=unit(0.5, "lines")) +
    # geom_rect(xmin = -Inf,xmax = Inf,
    #           ymin = -Inf,ymax = Inf,fill=NA,color="black") + 
    guides(fill="none") +
    
    labs(x="", y="", color="", fill="") + 
    ggtitle(
      paste0("Scenario ", str_sub(scenario,1,1), " ", target_outcome, " per 100K - Empirical and Ensemble Projections, by State",
             "\n",
             "(", min_max_dates[1], " - ", min_max_dates[2], ")"
      )
    )
  
  pp <- ggplotly(p,height = 900)
  

  fix_projection_point_text <- function(x) {
    paste0("Projected: ", str_extract(x,"\\d{4}-\\d{2}-\\d{2}"), ": ", round(as.numeric(str_extract(x,"(?<=value: )[0-9.\\s]{1,11}")),2))
  }
  
  fix_projection_fill_text <- function(x) {
    paste0("Range: ",
           #round(as.numeric(str_extract(x,"(?<=low_per_pop: )[0-9.\\s]{1,11}")),2),
           round(as.numeric(str_extract(x,"(?<=lower: )[0-9.\\s]{1,11}")),2),
           "-",
           #round(as.numeric(str_extract(x,"(?<=upp_per_pop: )[0-9.\\s]{1,11}")),2)
           round(as.numeric(str_extract(x,"(?<=upper: )[0-9.\\s]{1,11}")),2)
           
    )
  }
  
  
  fix_observed_point_text <- function(x) {
    paste0("Observed: ", round(as.numeric(str_extract(x,"(?<=value: )[0-9.\\s]{1,11}")),2))
  }
  
  draw_box_around_plot <- function(axis) {
    axis$showline=T
    axis$linecolor="black"
    axis$mirror = "all"
    axis
  }
  
  # if legend group has projection, cahnge to projection
  for(i in seq(1,length(pp$x$data))) {
    lg = pp$x$data[[i]]$legendgroup
    na = pp$x$data[[i]]$name
    
    
    if(!is.null(lg)) {
      if(str_detect(lg, "Projection"))  pp$x$data[[i]]$legendgroup = "Projection"
      if(str_detect(lg, "Observed"))  pp$x$data[[i]]$legendgroup = "Observed"
      if(na %in% c("(Projection,1)", "(Observed,1)") & i<111) {
        pp$x$data[[i]]$showlegend=TRUE
      } else {
        pp$x$data[[i]]$showlegend=FALSE
      }
      if(na == "(Projection,1)") pp$x$data[[i]]$name = "Projections"
      if(na == "(Observed,1)") pp$x$data[[i]]$name = "Observed"
      
      # We can also updated the xaxis and yaxis lines for this subplot
      axis_names = c(
        str_replace(pp$x$data[[i]]$xaxis, "x", "xaxis"),
        str_replace(pp$x$data[[i]]$yaxis, "y", "yaxis")
      )
      pp$x$layout[[axis_names[1]]] <- draw_box_around_plot(pp$x$layout[[axis_names[1]]])
      pp$x$layout[[axis_names[2]]] <- draw_box_around_plot(pp$x$layout[[axis_names[2]]])
      
      
    }
    
    
    
    
    # fix hover text for projection
    if(str_detect(na,"Projection")) {
      if(is.null(pp$x$data[[i]]$fill)) {
        pp$x$data[[i]]$text = unlist(lapply(pp$x$data[[i]]$text, fix_projection_point_text))  
        
      } else {
        pp$x$data[[i]]$text = unlist(lapply(pp$x$data[[i]]$text, fix_projection_fill_text))  
      }
      
    }
    # fix hover text for projection
    if(str_detect(na,"Observed")) {
      pp$x$data[[i]]$text = unlist(lapply(pp$x$data[[i]]$text, fix_observed_point_text))
    }
    
  }
  
  # can we fix the xaxis domains?
  fix_x_axis_domains <- function(pp, width = 0.04087418, distance_bw = 0.03905297) {
    domains <- lapply(1:13, function(x) {
      start = (x-1)*(width+distance_bw)
      end = start + width
      c(start,end)
    })
    
    for(i in seq(1,104)) {
      if(i==1) an="xaxis"
      else an=paste0("xaxis", i)
      
      if(i%%13==0) new_domain = domains[[13]]
      else new_domain = domains[[i%%13]]
      
      pp$x$layout[[an]]$domain = new_domain
      
    }
    
    return(pp)
  }
  
  pp <- fix_x_axis_domains(pp)
  
  #remove the line break in title
  pp$x$layout$title$text = str_replace(pp$x$layout$title$text,"\n"," ")
  
  fig <- pp %>% layout(
    hovermode="x unified",
    legend=list(orientation="h", y=-0.01, x=0.5),
    annotations = list(
      list(x = -0.02 , y = 0.5, text = paste0(target_outcome, " / 100K"),
           font = list(color = "black",size = 12),
           textangle = 270,
           showarrow = F, xref='paper', yref='paper', size=16))
  )
  
  return(fig)
  
}


# fig <- create_quasi_map(gginput,scenario = "D-2021-07-13", target_outcome = "Incident Deaths")
# fig
# api_create(fig,
#            filename=paste0(
#              "rnd",
#              rnd_num,
#              "_scenario_",
#              scenario,
#              "_compare_to_empir_quasi_map",
#              target_outcome
#              )
# )


