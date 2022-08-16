# Generate scenario comparison box plot (i.e. excess outcomes etc.)

get_endvalues <- function(x) {
  return(
    x[i=str_detect(outcome, "Incident") & is.na(quantile)==TRUE,
      j=.(endvalue = sum(value)),
      by=.(outcome, location_name, model_name, scenario_id)]
  )
}

get_endvalues_using_zero_cum <- function(zc, endweek=26) {
  
  
  # Alternative way to get all the cumulative values!
  return(
    rbind(
      zc[is.na(quantile) & str_detect(outcome, "Cumulative") & target_wk==endweek][, .(scenario_id, location_name, outcome, model_name,"endvalue" = value, "week" = 0)],
      zc[is.na(quantile) & str_detect(outcome, "Cumulative")][, .("endvalue" = max(value)-value, "week" = target_wk), by=.(scenario_id, location_name, outcome, model_name)]
      )
  )
}

get_endvalues_using_cum <- function(cd) {
  
  model_max_weeks <- cd[,.(max_week = max(target_wk, na.rm=F)),
                        by=.(scenario_id, outcome, location_name, model_name)]
  
  
  return(
    cd[model_max_weeks, on=.(scenario_id, outcome, location_name, model_name, target_wk=max_week), nomatch=0][
      i=str_detect(outcome, "Cumulative") & is.na(quantile)==TRUE,
      j=.(endvalue = value),
      by=.(outcome, location_name, model_name, scenario_id)]
  )
}


get_relative_change <- function(ev, comp_scenarios, ref_scenarios, value_var, rnd_num) {
  
  on_vars = c("outcome", "location_name", "model_name")
  if("week" %in% colnames(ev)) on_vars = c(on_vars, "week")
  
  
  ref_vals <- ev[scenario_id %in% comp_scenarios][
    ev[scenario_id %in% ref_scenarios], 
    on=on_vars, allow.cartesian=TRUE]
  
  ref_vals[["rel_change"]] <- (ref_vals[[value_var]]/ref_vals[[paste0("i.",value_var)]]) - 1
  
  # the comp and ref are in order.. We can 
  ref_vals <- ref_vals[!(scenario_id == comp_scenarios[[1]] & i.scenario_id == ref_scenarios[[2]])]
  ref_vals <- ref_vals[!(scenario_id == comp_scenarios[[2]] & i.scenario_id == ref_scenarios[[1]])]
  
  for(nm in names(ref_scenarios)) {
    ref_vals[i.scenario_id == ref_scenarios[[nm]], comparison:=nm]
  }
  
  # We could have multiple models set to Ensemble.  If so, we should remove rows
  # that aren't the default ensemble
  
  ensembles = unique(ref_vals[str_detect(model_name, "Ensemble"), model_name])
  
  if(length(ensembles)>1) {
    ref_vals <- ref_vals[
      !model_name %in% ensembles[which(ensembles!=get_default_ensemble_fixed(rnd_num))]
      ]
  }

  ref_vals[,ens_flag:=str_detect(model_name, "Ensemble")]  
  
  return_vars = c(on_vars, "scenario_id", "rel_change", "comparison", "ens_flag")
  return(
    ref_vals[,..return_vars ]
  )
  
}

scenario_comparison_lookup <- 
  list(
    #Round 1
    list(),
    #Round 2
    list(comp_scenarios = list("C-2021-01-22","D-2021-01-22"),
         ref_scenarios = list("No Variant Strain (Compares C to A)" = "A-2021-01-22",
                              "Variant Strain (Compares D to B)" = "B-2021-01-22")
    ),
    #Round 3
    list(comp_scenarios = list("C-2021-03-05","D-2021-03-05"),
         ref_scenarios = list("Moderate NPI (Compares C to A)" = "A-2021-03-05",
                              "Low NPI (Compares D to B)" = "B-2021-03-05")
    ),
    #Round 4
    list(comp_scenarios = list("C-2021-03-28","D-2021-03-28"),
         ref_scenarios = list("Moderate NPI (Compares C to A)" = "A-2021-03-28",
                              "Low NPI (Compares D to B)" = "B-2021-03-28")
    ),
    #Round 5
    list(comp_scenarios = list("C-2021-05-02","D-2021-05-02"),
         ref_scenarios = list("Moderate NPI (Compares C to A)" = "A-2021-05-02",
                              "Low NPI (Compares D to B)" = "B-2021-05-02")
    ),
    #Round 6
    list(comp_scenarios = list("C-2021-06-08","D-2021-06-08"),
         ref_scenarios = list("Low Transmission Variant (Compares C to A)" = "A-2021-06-08",
                              "High Transmission Variant (Compares D to B)" = "B-2021-06-08")
    ),
    #Round 7
    list(comp_scenarios = list("C-2021-07-13","D-2021-07-13"),
         ref_scenarios = list("Low Transmission Variant (Compares C to A)" = "A-2021-07-13",
                              "High Transmission Variant (Compares D to B)" = "B-2021-07-13")
    ), 
    #Round 8
    list(),
    #Round 9
    list(comp_scenarios = list("B-2021-09-14","D-2021-09-14"),
         ref_scenarios = list("No New Variant (Compares No Childhood Vax (B) to Childhood Vax (A))" = "A-2021-09-14",
                              "Variant (Compares No Childhood Vax (D) to Childhood Vax (C))" = "C-2021-09-14")
         ),
    #Round 10
    list(comp_scenarios = list("B-2021-11-09","D-2021-11-09"),
         ref_scenarios = list("Optimistic Waning (Compares restricted booster (B) to widespread booster (A))" = "A-2021-11-09",
                              "Pessimistic Waning (Compares restricted booster (D) to widespread booster (C))" = "C-2021-11-09")),
    
    #Round 11
    list(comp_scenarios = list("B-2021-12-21","D-2021-12-21"),
         ref_scenarios = list("Optimistic severity (Compares low immmune escape/high transmissibility increase (B) to high immune escape/low transmissibility increase (A))" = "A-2021-12-21",
                              "Pessimistic severity (Compares low immmune escape/high transmissibility increase (D) to high immune escape/low transmissibility increase (C))" = "C-2021-12-21")),

    #Round 12
    list(comp_scenarios = list("B-2022-01-09","D-2022-01-09"),
         ref_scenarios = list("Optimistic severity (Compares low immmune escape (B) to high immune escape (A))" = "A-2022-01-09",
                              "Pessimistic severity (Compares low immmune escape (D) to high immune escape (C))" = "C-2022-01-09")),
    
    #Round 13
    list(comp_scenarios = list("C-2022-02-25","D-2022-02-25"),
         ref_scenarios = list("No immune escape variant (Compares (C) to  (A))" = "A-2022-02-25",
                              "New immune escape variant (Compares  (D) to  (B))" = "B-2022-02-25")),
    
    #Round 14
    list(comp_scenarios = list("A-2022-05-09","B-2022-05-09"),
         ref_scenarios = list("No immune escape variant (Compares (A) to  (C))" = "C-2022-05-09",
                              "New immune escape variant (Compares  (B) to  (D))" = "D-2022-05-09")),
    
    #Round 15
    list(comp_scenarios = list("C-2022-07-19","D-2022-07-19"),
         ref_scenarios = list("No immune escape variant (Compares (C) to  (A))" = "A-2022-07-19",
                              "New immune escape variant (Compares  (D) to  (B))" = "B-2022-07-19"))
    

  )

# Function to get the scenario_comparison data
get_scen_comp_data <- function(rnd_num, model_data, method=c("sum_incidence", "overall_cum", "zero_cum"),...) {
  
  # get the maximum week that this comparison will go to (i.e. always the max week of the ensemble)
  to_week= fifelse(rnd_num==5, 26, max(model_data$target_wk))
  
  method = match.arg(method)
  if(method=="sum_incidence") end_value_function = get_endvalues
  if(method=="overall_cum") end_value_function = get_endvalues_using_cum
  if(method=="zero_cum") end_value_function = get_endvalues_using_zero_cum
  
  comp_scenarios <- scenario_comparison_lookup[[rnd_num]][["comp_scenarios"]]
  ref_scenarios <- scenario_comparison_lookup[[rnd_num]][["ref_scenarios"]]
  
  if(is.null(comp_scenarios)) return(NULL)
  
  # get the end values
  ev <- end_value_function(model_data, ...)
  
  # get the relative change
  rel <- get_relative_change(
    ev = ev,
    comp_scenarios = comp_scenarios,
    ref_scenarios = ref_scenarios,
    value_var = "endvalue", rnd_num = rnd_num
    )
  
  # change outcome to numeric in order we want
  rel[,outcome:=fcase(
      str_detect(outcome, "Cases"), 1,
      str_detect(outcome, "Hospitalizations"), 2,
      str_detect(outcome, "Deaths"),3
    )
    ]
  
  # add on the to_week colum
  rel[,to_week:=to_week]

  return(rel)
  
}

# # Need a function to get the scenario_comparison_plot
# create_scenario_comparison_plot <- function(scen_comp_data = NULL, loc_name="US") {
#   
#   
#   if(is.null(scen_comp_data)) return(NULL)
#   
#   scen_comp_data = scen_comp_data[location_name==loc_name]
#   
#   errbr <- scen_comp_data %>%
#     group_by(scenario_id, outcome, comparison) %>% 
#     summarise(min = min(rel_change, na.rm=T),
#             max = max(rel_change, na.rm=T),
#             .groups="drop")
# 
#   lim = c(0, max(scen_comp_data$rel_change))
# 
#   p <- ggplot(data = scen_comp_data,
#          aes(x = comparison)) +
#     geom_hline(aes(yintercept = 0), linetype = "dashed")+
#     geom_linerange(data = errbr, aes(ymin = min, ymax = max), 
#                  position = position_dodge(width = 0.6), size=1.2) +
#     geom_point(data = scen_comp_data %>% filter(ens_flag==FALSE), 
#              aes(y = rel_change, color = model_name), fill = "white", size = 5, alpha = 0.5)+
#     geom_segment(data = scen_comp_data %>% filter(ens_flag==TRUE),
#                aes(x = as.numeric(factor(comparison)) - 0.05, xend = as.numeric(factor(comparison)) + 0.05,
#                    y = rel_change, yend = rel_change), size =1)+
#     #guides(alpha = FALSE, shape = FALSE, label = FALSE, color = guide_legend(override.aes = list(linetype = c(0, 0, 0))))+
#     #scale_color_manual(values = model_colors)+
#     scale_y_continuous(labels = scales::percent_format(accuracy = 1), name = "% Excess")+ #,limits = lim
#     facet_grid(cols = vars(outcome)) +
#     theme_classic()+
#     ggtitle(paste0(
#       "Excess percentage of reported cases, hospitalizations, and deaths compared with the",
#       "\n most optimistic scenario (",loc_name,")"))+
#     theme(axis.title.x = element_blank(),
#           legend.position = "bottom",
#           legend.title = element_blank(),
#           plot.title = element_text(hjust = 0.5),
#           text = element_text(size=16))
# 
#   return(p)
# }



comparison_plot <- function(df, showlegend=F, y_range=NULL) {
  
  title = unique(df$comparison)
  
  plot_ly(height = 1050) %>% 
    add_trace(
      data = df[ens_flag==FALSE], 
      x=~outcome,
      legendgroup=~model_name,
      color=~model_name,
      colors=get_model_colors(df),
      
      y=~rel_change,
      type="scatter",
      mode="markers",
      marker = list(symbol = "circle-dot", size=21),
      showlegend=showlegend
    ) %>% 
    add_trace(
      data = df[ens_flag==TRUE], 
      x=~outcome,
      legendgroup=~model_name,
      color=~model_name,
      colors=get_model_colors(df),
      y=~rel_change,
      type="scatter",
      mode="markers",
      marker = list(symbol="diamond-wide",size=24),
      showlegend=showlegend
    ) %>% 
    
    add_segments(
      data=NULL,
      x=1, xend=3, y=0, yend=0, line=list(color="black", dash="dot"), showlegend=FALSE
    ) %>% 
    add_annotations(
      text = title,
      x = 0.0,
      y = 1.06,
      yref = "y domain", xref = "paper",
      xanchor = "left",
      yanchor = "top",
      showarrow = FALSE,
      font = list(size = 15)
    ) %>% 
    layout(
      yaxis = list(
        title="Relative Change",
        tickformat = "%",
        showline = TRUE,
        mirror = "ticks",
        linecolor = toRGB("black"),
        linewidth = 2,
        range=y_range
        ),
      xaxis = list(
        tickangle = 20,
        tickfont = list(size=12),
        tickvals = c(1,2,3),
        ticktext = c("Cases", "Hospitalizations", "Deaths"),
        showline = TRUE,
        mirror = "ticks",
        linecolor = toRGB("black"),
        linewidth = 2
        )
    )
}


create_scenario_comparison_plotly <- function(scen_comp_data = NULL, loc_name="US") {
  
  if(is.null(scen_comp_data)) return(NULL)
  
  scen_comp_data = scen_comp_data[location_name==loc_name]
  
  # get the max week (so that the title can be specific)
  if(uniqueN(scen_comp_data$week)>1) {
    stop("Error: too many weeks in scen_comp_data")
  }
  
  if("week" %in% names(scen_comp_data)) {
    from_week = unique(scen_comp_data$week) + 1  
  } else {
    from_week = 1
  }
  to_week = unique(scen_comp_data$to_week)
  
  
  # keep only rows with finite values in rel change?
  scen_comp_data <- scen_comp_data[is.finite(rel_change)]
  
  # Get the range
  y_range = scen_comp_data[, c(min(rel_change, na.rm=F), max(rel_change, na.rm=F))]
  
  # The bottom of this range cannot exceed zero (it can of course be negative)
  if(y_range[1]>0) y_range[1]=-0.10

  # add 20%
  y_range <-y_range*1.2
  
  scen_comp_data[, model_name:=as.character(model_name)]
  
  comp_levels = levels(as.factor(scen_comp_data$comparison))
  
  comp_1_plot <- comparison_plot(scen_comp_data[comparison == comp_levels[1]], showlegend=T, y_range = y_range)
  comp_2_plot <- comparison_plot(scen_comp_data[comparison == comp_levels[2]], showlegend=F, y_range= y_range)

  p <- subplot(list(comp_1_plot, comp_2_plot), shareY=FALSE, shareX=FALSE) %>%
    layout(legend=list(orientation="h"),
        #   height=1050, 
           margin=0.1,
           yaxis = list(tickformat= ".1%"),
           yaxis2 = list(tickformat= ".1%"),
           title = list(
             text = paste0(
               "Excess percentage of reported cases, hospitalizations, and deaths compared with the",
               "\n most optimistic scenario (",loc_name,"); Projection Wk ", from_week, "-", to_week),
             xref = "container", yref="container", x=0, y=0.98, xanchor="left",
             pad =list(b=30)
             
           )
    )
  
  return(p)
}

