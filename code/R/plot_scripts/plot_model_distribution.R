# near_quantiles <- function(x, q=c(0.01, 0.25, 0.5, 0.75, 0.99)) {
#   lapply(q, function(y) near(x,y=y))
# }

# get_model_dist_data <- function(rnd, model_data) {
# 
# 
#   # change the point estimate of the ensemble to quantile 0.5
#   subset <- data.table::copy(model_data)[str_detect(model_name, "Ensemble") & is.na(quantile)==TRUE, `:=`(quantile=0.50)]
#   
#   # Get locations
#   subset <- locations[,.(location_name, population)][subset, on="location_name"]
#   
#   # Create a flag for model type
#   subset[, model_type:=fifelse(str_detect(model_name, "Ensemble"), "Ensemble", "Individual")]
#   
#   # Get the set of quantiles we are after
#   subset <- subset[rowSums(subset[, near_quantiles(quantile)])==1,]
# 
#   
#   return(subset)
# }


# create_model_dist_plot <- function(dist_plot_data, location="US", wk=13, outcome_type = "Incident Cases") {
# 
#   outcome_type = str_extract(outcome_type, "Inc|Cum")  
#   #print(outcome_type)
#   
#   gg_input <- dist_plot_data[location_name == location & target_wk == wk & str_detect(outcome, outcome_type)]
# 
#   p <- ggplot(gg_input, aes(x=value*100000/population, y=factor(model_name), fill=model_type)) +
#     geom_boxplot(coef=100) + 
#     facet_grid(rows=vars(scenario_id), cols=vars(outcome), scales="free_x") +
#     scale_x_sqrt() + 
#     scale_fill_manual(values=c("#69b3a2", "grey")) + 
#     labs(x=paste0("Outcomes per 100,000 pop at Week ", wk), y="", fill="") +
#     theme(legend.position="None",
#           text = element_text(size=24),
#           plot.title = element_text(hjust = 0.5)) + 
#     ggtitle(paste0("Distribution of Projections, by Outcome, Model, and Scenario\n(Week: ", wk, "; Location: ", location, ")"))
#   
#   return(p)
# 
# }

create_model_dist_plotly <- function(model_data, location="US", wk=13, outcome_type = "Incident",
                                     scenarios=NULL,
                                     x_scale = "absolute", 
                                     rd_num = NULL, ens_chk = NULL) {
  
  if (isFALSE(ens_chk)) {
    ens_exc <- unique(scen_info[rnd_num == rd_num, ens_excl])
    model_data <- model_data[grep(ens_exc, model_name, invert = TRUE)]
  }
  
  outcome_type = str_extract(outcome_type, "Inc|Cum")  
  
  # get input data for the plot
  gg_input <- model_data[location_name == location & target_wk == wk & str_detect(outcome, outcome_type)]
  
  # get rate and outcome variables
  if(x_scale == "per 100k") {
    gg_input[locations[,.(location_name, population)],
             `:=`(
               rate=value*100000/population,
               outcome=str_extract(outcome, "Cases|Deaths|Hospitalizations")),
             on="location_name"
    ]
  } else {
    gg_input[locations[,.(location_name, population)],
             `:=`(
               rate=value,
               outcome=str_extract(outcome, "Cases|Deaths|Hospitalizations")),
             on="location_name"
    ]
    
  }
  
  # cast it wide for plotly
  gg_input <- dcast(gg_input, outcome+scenario_id+model_name~quantile, value.var="rate")
  
  gg_input[, model_type:=fifelse(str_detect(model_name, "Ensemble"), "Ensemble", "Individual")]
  
  # treat the factor as a character variable
  gg_input[, model_name:=as.character(model_name)]
  
  # fix to more convenient names
  setnames(gg_input, old=c("0.01","0.25","0.5", "0.75", "0.99"), new=c("lower", "q1", "med", "q3", "upper"))
  
  # replace NA in the 0.5 column
  gg_input[is.na(med), med:=`NA`]
  
  # if scenarios is null, then we take all, otherwise filter
  if(!is.null(scenarios)) {
    gg_input <- gg_input[scenario_id %in% scenarios]
  }
  
  
  # Make box plot function
  box_plot <- function(data) {
    p <- plot_ly(data = data,
                 y=~model_name,
                 q1 = ~q1, 
                 median = ~med,
                 q3 = ~q3,
                 lowerfence = ~lower,
                 upperfence = ~upper,
                 type="box", 
                 color = ~model_type,
                 fillcolor = ~model_type,
                 colors=c("Individual"= "black", "Ensemble"="darkgreen"),
                 showlegend = FALSE,
                 height = 1000
    ) %>% 
      layout(
        yaxis=list(title="", tickfont = list(size = 10))
      )
    return(p)
  }
  
  # Get unique scenarios
  scens <- unique(gg_input$scenario_id)
  num_scens = length(scens)
  
  # Create three subplots
  dist_plots <- lapply(c("Cases","Hospitalizations","Deaths"), function(outcome_type) {
    scen_plots <- lapply(scens, function(scen) {
      box_plot(gg_input[outcome==outcome_type & scenario_id == scen])
    })
    scen_plot <- subplot(scen_plots, nrows=num_scens, shareY = T, shareX=T)
    
    return(scen_plot)
  })
  
  # Combine the three subplots into a single plot
  p <- subplot(dist_plots, shareY=F, shareX=F)
  
  
  # make some y axis invisible
  axis_to_make_invisible <- unique(str_replace(
    unlist(sapply(p$x$data, function(q) if(q$xaxis != "x") q$yaxis)),
    "y","yaxis"
  ))
  
  # for(i in seq_along(axis_to_make_invisible)) {
  #   p$x$layout[[axis_to_make_invisible[[i]]]]$visible=FALSE
  # }
  
  # We need to add annotations, but we don't know what Scenario Annotations we need.
  outcome_annotations <- list(
    list(x = 0.0 , y = 1.05, text = "<b>Cases</b>", font=list(size=12), showarrow = F, xref='paper', yref='paper'),
    list(x = 0.33 , y = 1.05, text = "<b>Hospitalizations</b>", font=list(size=12),showarrow = F, xref='paper', yref='paper'),
    list(x = 0.66 , y = 1.05, text = "<b>Deaths</b>", font=list(size=12),showarrow = F, xref='paper', yref='paper')
  )
  scenario_annotations <- lapply(scens, function(s) {
    list(x = 1.01 , text = paste0("<b>", s, "</b>"), showarrow = F, xref='paper', yref='paper', textangle=90)
  })
  
  if(x_scale == "per 100k") {
    xaxis_title= "(per 100k)"
  } else {
    xaxis_title= "(N)"
  }
  
  xaxis_annotations <- list(
    list(x = 0.12 , y = -0.07, text = paste("<b>Cases ", xaxis_title, "</b>"), font=list(size=12), showarrow = F, xref='paper', yref='paper'),
    list(x = 0.50 , y = -0.07, text = paste("<b>Hospitalizations ", xaxis_title, "</b>"), font=list(size=12),showarrow = F, xref='paper', yref='paper'),
    list(x = 0.88 , y = -0.07, text = paste("<b>Deaths ", xaxis_title, "</b>"), font=list(size=12),showarrow = F, xref='paper', yref='paper')
  )
  
  
  if(num_scens ==1) scenario_annotations[[1]]$y=0.5
  if(num_scens ==2) {
    scenario_annotations[[1]]$y=0.75
    scenario_annotations[[2]]$y=0.25
  }
  if(num_scens ==3) {
    scenario_annotations[[1]]$y=1
    scenario_annotations[[2]]$y=0.5
    scenario_annotations[[3]]$y=0.0
  }
  if(num_scens ==4) {
    scenario_annotations[[1]]$y=1
    scenario_annotations[[2]]$y=0.66
    scenario_annotations[[3]]$y=0.33
    scenario_annotations[[4]]$y=0.0
  }
  
  plot_title <- paste0("Distribution of Projections, by Outcome, Model, and Scenario (Week: ", wk, "; Location: ", location, ")")
  
  p <- p %>% 
    layout(annotations = c(outcome_annotations,scenario_annotations, xaxis_annotations),
           margin=0.1,
           title=list(
             text=plot_title,
             xref = "container", yref="container", x=0, y=1.10, xanchor="left",
             pad =list(b=30)
           )#,
             #x=0.0, xref='paper',y=1.10, yref='paper',margin=list(b=40)),
          # height=900
    )
  
  return(p)
  
  
}
