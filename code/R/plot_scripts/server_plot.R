server_plot <- function(model_data, target, loc, scen_sel, pi, rtab) {
  
  # GOLD STANDARD DATA
  gs_target <- getOption("gs_targets")[[target]]
  if (gs_target == "cumulative_hospitalization") {
    gs_visual <- data.frame(NULL)
  } else {
    gs_visual <- gs_data[[target]]
    gs_visual <- gs_visual[geo_value_fullname == loc]
    gs_visual <- gs_visual[!is.na(value)]
    gs_visual <- gs_visual[ value >= 0]
  }
  # PROJECTION DATA 
  round_number <- as.numeric(gsub("[^[:digit:]]", "", rtab))
  model_round <- gsub(" ", "", tolower(rtab))
  if (gs_target == "cumulative_hospitalization" & (length(scen_sel) == 0)) { 
    # Error for cumulative hospitalization
    stop("Please select one or more scenario(s)")
  }
  model_visual <- mutate_if(model_data, is.factor, as.vector)
  model_visual <- model_visual[scenario_id %in% scen_sel & location_name == loc & 
                             outcome == target]
  model_visual[ , target_end_date := as.Date(target_end_date)]
  if (round_number > 2 & round_number < 7)  {
    model_visual <- model_visual[truncated == 0]
  }
  if ("truncated" %in% colnames(model_visual)) 
    model_visual <- model_visual[, !"truncated"]
  
  # filter to the last 6 months of data
  # Date of prediction use for filtering and for gray vertical line
  if (model_round == "round1" & !is.null(scen_sel)) {
    pred_date <- as.Date("2021-01-02")
  } else {
    if (!is.null(scen_sel)) {
      pred_date <- min(model_visual$target_end_date) - 7
    } else {
        pred_date <- wtoday
      }
  }
  if (gs_target != "cumulative_hospitalization" & (!is.null(scen_sel))) {
    if (round_number < 10) {
      gs_visual <- gs_visual[time_value < pred_date + period(27, "weeks")]
    } else {
      gs_visual <- gs_visual[time_value < pred_date + period(53, "weeks")]
    }
    
  }
  
  # Select Projection Intervals
  prep_wider_quantile <- function(df, quantiles) {
    df <- group_by(df, model_name, scenario_id, target_end_date) %>%
      filter(quantile %in% quantiles) %>% ungroup() %>% data.table()
    df[, quantile := ifelse(
      is.na(quantile), "point", ifelse(quantile == min(quantiles, na.rm = TRUE),
                                       "min", "max"))]
    df <- tidyr::pivot_wider(df, names_from = quantile, values_from = value) 
    #df <- tidyr::unnest(df, cols = c(point, min, max))
    df <- data.table(df)
    df[, rm_na := ifelse(is.na(min), 1, ifelse(is.na(max), 1, 0))]
    df <- df[!grepl(1, rm_na)]
  }
  
  ## Sets up data fo the  
  prep_multi_quantile <- function(df, quantiles=c(0.025, 0.05, 0.1, 0.25,
                                                  0.75, 0.9, 0.95, 0.975)) {
    
    df <- group_by(df, model_name, scenario_id, target_end_date) %>%
      filter(quantile %in% c(quantiles,NA)) %>% ungroup() %>% data.table()
    
    df[, quantile := ifelse(
      is.na(quantile), "point", quantile)]
    
    df <- tidyr::pivot_wider(df, names_from = quantile, values_from = value) 
    
    ## Having columns named min and max here will help with
    ## other code
    df <- df %>% 
      mutate(min = `0.025`, max = `0.975`)
    df <- data.table(df)
    
  }
  
  if (!is.null(scen_sel)) {
    if (pi == 50) {
      model_visual <- prep_wider_quantile(model_visual, c(0.250, 0.750, NA))
    }
    if (pi == 95) {
      model_visual <- prep_wider_quantile(model_visual, c(0.025, 0.975, NA))
    }
    if (pi == 0) {
      model_visual <- model_visual[is.na(quantile)]
      setnames(model_visual, old = "value", new = "point")
      model_visual <- model_visual[, !c("quantile")]
    }
    ## pi =  -1 use to designate showing multiple PI levels
    if (pi == -1) {
      #print("In multi-PI level code")
      if (round_number >= 11) {
        model_visual <- prep_multi_quantile(model_visual,
                                            quantiles=c(0.025, 0.05, 0.1, 0.25,
                                                        0.75, 0.9, 0.95, 0.975))
      } else {
        model_visual <- prep_multi_quantile(model_visual,
                                            quantiles=c(0.025, 0.25, 0.75, 
                                                        0.975))
      }                   
    }
     
    
    if (round_number %in% c(6, 7, 12)) {
      model_visual[, model_name := gsub("UNCC-hierbin", "UNCC-hierbin*", 
                                        model_name)]
      if (round_number == 12) {
        model_visual[, model_name := gsub("UTA-ImmunoSEIRS", "UTA-ImmunoSEIRS*", 
                                          model_name)]
      }
    }
    if (round_number %in% c(9)) {
      model_visual[, model_name := gsub("MOBS_NEU-GLEAM_COVID$", 
                                        "MOBS_NEU-GLEAM_COVID*", 
                                        model_name)]
      model_visual[, model_name := gsub("UVA-EpiHiper", "UVA-EpiHiper*", 
                                        model_name)]
      model_visual[, model_name := gsub("USC-SIkJalpha", "USC-SIkJalpha*", 
                                        model_name)] 
    }
    model_visual[, order := ifelse(
      grepl("Ensemble_LOP_untrimmed$", model_name) & round_number == 13, 1, 
      ifelse(grepl("Ensemble_LOP$", model_name) & round_number > 4, 1, 
      ifelse(grepl("Ensemble$", model_name) & round_number < 5, 1, 0)))]
    model_visual$mod_o <- as.factor(apply(model_visual[,c("order", "model_name")],
                                          1, paste, collapse="-")) 
  }
  ## Restrict visual to 26 or 52 weeks projections
  model_visual <- model_visual[target_wk <= unique(
    scen_info[rnd_num == round_number, proj_length])]

  
# -----------------------------------------------------------------------------
  
  #PLOT 
  # Axis
  if (gs_target == "cumulative_hospitalization") {
    min_x <- pred_date - 1
    max_x <- max(model_visual$target_end_date, na.rm = TRUE)
    min_y <- - 1000
    max_y <- max(model_visual$max, model_visual$point, na.rm = TRUE)
  } else {
    min_x <- min(gs_visual$time_value, na.rm = TRUE)
    min_y <- min(gs_visual$value, na.rm = TRUE)
    if (!is.null(scen_sel)) {
      max_x <- max(model_visual$target_end_date, na.rm = TRUE)
      max_y <- max(model_visual$max, model_visual$point, na.rm = TRUE)
    } else {
      max_x <- max(gs_visual$time_value, na.rm = TRUE)
      max_y <- max(gs_visual$value, na.rm = TRUE)
    }
  }
  x_vals <- seq(min_x, max_x, 56)
  x_text <- paste(epiweek(x_vals), format(x_vals, "%m/%d/%y"), sep = "<br>")
  lab_x <- " <br> <br>Epiweek<br>End Date for Epiweek"
  y_name_title <- target
  y_name <- paste0("Observed ", y_name_title)
 
  # Vertical lines + subplot title
  pred_vline <- list(type = "line", y0 = 0, y1 = 1, yref = "paper", 
                     x0 = pred_date, x1 = pred_date, 
                     line = list(color = "gray"))
  week_vline <- list(type = "line", y0 = 0, y1 = 1, yref = "paper", 
                     x0 = wtoday, x1 = wtoday, 
                     line = list(color = "gray", dash = "dash"))
  
  # prior peak line (only for incident outcomes, round 11 and 12)
  
  if(round_number %in% c(11,12) & grepl("Incident",target)) {
    prior_peak_value = gs_visual[time_value<"2021-12-01" & !is.na(value)][order(-value)][1]
    prior_peak_hline <- list(
      type="line", y0=prior_peak_value[,value], y1=prior_peak_value[,value], 
      x0=0, x1=1, xref="paper", line=list(color="red", dash="dot"), text="Prior Peak"
    )
  }

  
  
  # Gold Standard data
  if (gs_target != "cumulative_hospitalization") {
    
    plot_model <- plot_ly(height = 1050,
      colors = scales::hue_pal()(50)) %>% 
      add_trace(data = gs_visual, x = ~time_value, y = ~value, type = "scatter",
                mode = "lines+markers", line = list(color = "#6e6e6e"),
                hoverinfo = "text", name = y_name, legendgroup = "group1",
                hovertext = paste("Date: ", gs_visual$time_value, "<br>", y_name,
                             ": ", format(gs_visual$value, big.mark = ","), 
                             sep = ""), 
                marker = list(color = "#6e6e6e", size = 7))
    
  } else { 
    plot_model <- plot_ly(height = 1050,
      colors = scales::hue_pal()(length(unique(model_visual$model_name))))
  }
  
  # Plot layout
 if (length(unique(model_visual$scenario_id)) <= 2) {
   nrow_plot <- 1
 } else if (length(unique(model_visual$scenario_id)) == 3) {
   nrow_plot <- 3
 } else {
   nrow_plot <- 2
 }

  # Add model data
  if (!is.null(scen_sel)) {
    subplots <- lapply(sort(unique(model_visual$scenario_id)), function(x) {
      df <- model_visual[scenario_id == x]
      text_pi <- paste("Date: ", df$target_end_date,
                       "<br>", y_name_title,": ", 
                       format(round(df$point, 2), big.mark = ","),
                       "<br>Model: ", df$model_name,
                       "<br>Scenario: ", scenario_smname[x],
                       sep = "")
      
     
      if (pi!= -1) {
        
        #Non-multi projectoin interval mode
        plot_model <- plot_model %>% 
          add_lines(data = df, x = ~target_end_date, y = ~point, color = ~mod_o,
                    hoverinfo = "text", hovertext= text_pi)
        
      } else {
        
        ##Multiple projectoin interval mode
        text_pi <- paste(text_pi, "<br>", 95, "% Interval: ",
                         format(round(df$min, 2), big.mark = ","), 
                         " - ", 
                         format(round(df$max, 2), big.mark = ","),
                         sep = "")
        
        
        plot_model <- plot_model %>% 
          add_ribbons(data = df, x = ~target_end_date, ymin = ~`0.025`, ymax = ~`0.975`, 
                      color = ~mod_o, opacity = 0.1, line = list(width = 0),
                      hoverinfo = "text", hovertext= text_pi)%>%
          add_ribbons(data = df, x = ~target_end_date, ymin = ~`0.25`, ymax = ~`0.75`, 
                      color = ~mod_o, opacity = 0.1, line = list(width = 0),
                      hoverinfo = "text", hovertext= text_pi)
        
        if (round_number>=11) {
          
          plot_model <- plot_model %>% 
            add_ribbons(data = df, x = ~target_end_date, ymin = ~`0.05`, ymax = ~`0.95`, 
                        color = ~mod_o, opacity = 0.1, line = list(width = 0),
                        hoverinfo = "text", hovertext= text_pi)%>%
            add_ribbons(data = df, x = ~target_end_date, ymin = ~`0.1`, ymax = ~`0.9`, 
                        color = ~mod_o, opacity = 0.1, line = list(width = 0),
                        hoverinfo = "text", hovertext= text_pi)
        }
        
      }
      
      if (pi > 0) {
        text_pi <- paste(text_pi, "<br>", pi, "% Interval: ",
                         format(round(df$min, 2), big.mark = ","), 
                         " - ", 
                         format(round(df$max, 2), big.mark = ","),
                         sep = "")
        plot_model <- plot_model %>% 
          add_ribbons(data = df, x = ~target_end_date, ymin = ~min, ymax = ~max, 
                      color = ~mod_o, opacity = 0.25, line = list(width = 0),
                      hoverinfo = "text", hovertext= text_pi)
      }
      
      # Add shapes (v and hlines)
      if (wtoday <= (pred_date + period(27, "weeks"))) {
        shapes = list(pred_vline, week_vline) 
      } else {
        shapes = list(pred_vline)
      }
      if(round_number %in% c(11,12) & grepl("Incident", target)) {
        shapes = append(shapes, list(prior_peak_hline))
      }
      
      
      plot_model %>% 
        layout(xaxis = list(tickvals = as.list(x_vals), tickangle = 45, 
                            ticktext = as.list(x_text), mirror = TRUE, 
                            linecolor = "black", linewidth = 0.5),
               yaxis = list(mirror = TRUE, linecolor = "black", linewidth = 0.5),
               shapes = shapes, 
               annotations = list(x = 0.5, y = 1.075, xref = "paper",
                                  yref = "paper", xanchor = "center", 
                                  yanchor = "top", showarrow = FALSE,
                                  bgcolor = "#e0e0e0", bordercolor = "#a0a0a0",
                                  font = list(size = 14),
                                  text = paste("Scenario", 
                                               gsub("[^[:alpha:]]", "", x), ";", 
                                               gsub(" \\(.+\\)", "", 
                                                    grep(x, scenario_name, 
                                                         value = TRUE)))))
    })
   plot_model <- subplot(subplots, nrows = nrow_plot, titleX = FALSE, titleY = FALSE)

   # rm object subplots
   rm(subplots)
   
  } else { # if no scenarios are selected
    # Observed data with vertical lines
    if (wtoday <= (pred_date + period(27, "weeks"))) {
      plot_model <- plot_model %>%  
        layout(shapes = list(pred_vline, week_vline))
    } else {
      plot_model <- plot_model %>%  
        layout(shapes = list(pred_vline))
    }
    plot_model <- plot_model %>%
      layout(xaxis = list(tickvals = as.list(x_vals), tickangle = 45, 
                          ticktext = as.list(x_text), title = FALSE,
                          mirror = TRUE, linecolor = "black", linewidth = 0.5),
             yaxis = list(title = FALSE, mirror = TRUE, linecolor = "black", 
                          linewidth = 0.5))
  }
  # -------------------------------------------------------------------------
  if (!is.null(scen_sel)) { 
    # Legend
    for(i in 1:length(plot_model$x$data)) {
      plot_model$x$data[[i]]$name <- gsub("^\\(\\d-|\\)$|,.|^\\d-|^\\(", "", 
                                        plot_model$x$data[[i]]$name)
      if (length(plot_model$x$data[[i]]$name) == 0) {
        plot_model$x$data[[i]]$name <- y_name
      }
      plot_model$x$data[[i]]$legendgroup <- plot_model$x$data[[i]]$name
      plot_model$x$data[[i]]$visible <- "legendonly"
    }
    
    for (i in grep(y_name, purrr::map(plot_model$x$data, "name"))) {
      plot_model$x$data[[i]]$visible <- TRUE
    }
    name_plot <- unique(purrr::map(plot_model$x$data, "name")) %>% 
      gsub("[[:punct:]]", ".", .) %>% paste0(., "$")
    for (i in 1:length(name_plot)) {
      lst_group <- plot_model$x$data[grepl(
        name_plot[[i]], purrr::map(plot_model$x$data, "name"))]
      plot_model$x$data[grepl(
        name_plot[[i]], 
        purrr::map(plot_model$x$data, "name"))][[1]]$showlegend <- TRUE
      if (length(lst_group) > 1) {
        for (j in 2:length(lst_group)) {
          plot_model$x$data[grepl(
            name_plot[[i]], 
            purrr::map(plot_model$x$data, "name"))][[j]]$showlegend <- FALSE
        }
      }
    }
    # Ensemble Special form
    if (round_number > 4) {
      if (round_number == 13) {
        ens_def <- "^Ensemble_LOP_untrimmed$"
      } else {
        ens_def <- "^Ensemble_LOP$"
      }
    } else {
      ens_def <- "^Ensemble$"
    }
    sel <- grep(ens_def, map(plot_model$x$data, "name"))
    for (j in sel) {
      plot_model$x$data[[j]]$visible <- TRUE
      plot_model$x$data[[j]]$line$color <- "#3a3a3a"
      if (is.null(plot_model$x$data[[j]]$fill)) { #line
        plot_model$x$data[[j]]$mode <- "lines+markers"
        plot_model$x$data[[j]]$marker$color <- "#3a3a3a" 
        plot_model$x$data[[j]]$marker$line$color <- "#3a3a3a" 
        plot_model$x$data[[j]]$line$width <-  4
        plot_model$x$data[[j]]$marker$size <- 3
      } else {
        plot_model$x$data[[j]]$fillcolor <- "#3a3a3a"
        plot_model$x$data[[j]]$opacity <- 0.15
        }
    } 
    # Menu Model     
    if (round_number > 4) {
      if (round_number == 13) {
        view_def <- "Ensemble_LOP_untrimmed$|-Ensemble_LOP_untrimmed,|^$|^Observed"
      } else {
        view_def <- "Ensemble_LOP$|-Ensemble_LOP,|^$|^Observed"
      }
    } else {
      view_def <- "Ensemble$|-Ensemble,|^$|^Observed"
    }
    
    ##Take all away as an option if we are in multi mode.
    if (pi!=-1) {
      updatemenu <- list(
        list(y = 1, x = 1.01, xanchor = "left", type = "buttons", active = 0,
             font = list(size = 16),
             buttons = 
               c(list(list(method = "restyle",
                           args = list("visible", ifelse(
                             grepl(view_def, map(plot_model$x$data, "name")), 
                             TRUE, "legendonly")),
                           label = "Ensemble")),
                 list(list(method = "restyle",
                           args = list("visible", 
                                       rep(TRUE, length(plot_model$x$data))),
                           label = "All")))))
    } else {
      updatemenu <- list(
        list(y = 1, x = 1.01, xanchor = "left", type = "buttons", active = 0,
             font = list(size = 16),
             buttons = 
               c(list(list(method = "restyle",
                           args = list("visible", ifelse(
                             grepl(view_def, map(plot_model$x$data, "name")), 
                             TRUE, "legendonly")),
                           label = "Ensemble")))))
      
    }
  } else {
    updatemenu <- NULL
  }
  
  # Annotations + label axis
  annot <- list(list(text = "", y = -0.19, x = 0, xanchor = "left", 
                     xref = "paper", yref='paper', showarrow = FALSE, 
                     bordercolor = "white", width = 1500, height = NULL,
                     bgcolor = "#bfbfbf"),
                list(text = lab_x, font = list(size = 16), y = -0.18, x = 0.5, 
                     xanchor = "center", xref = "paper", yref='paper', 
                     showarrow = FALSE),
                list(text = y_name_title,
                     font = list(size = 16), y = 0.5, x = -0.05, textangle = 270,
                     xanchor = "center",  xref = "paper", yref='paper', 
                     showarrow = FALSE))
  if (!is.null(scen_sel)) {
    annot <- c(annot, list(
      list(text = "View:", font = list(size = 16),  y = 1.035, 
           x = 1.01, xanchor = "left",  xref = "paper", yref='paper', 
           showarrow = FALSE)))
    if (round_number %in% c(6, 7)) {
      annot <- c(annot,
                 list(
                   list(text = paste0("* A correction to the UNCC-Hierbin round ",
                                      round_number, " projections was made on 2021-07-23"),
                        font = list(size = 13, color = "grey"), y = -0.4, x = -0.02, xanchor = "left",
                        xref = "paper", yref='paper', showarrow = FALSE)))
    }
    if (round_number %in% c(9)) {
      annot <- c(annot,
                 list(
                   list(text = paste0("* A correction to the MOBS_NEU-GLEAM_COVID, UVA-EpiHiper and USC-SIkJalpha round ",
                                      round_number, " projections was made on 2021-10-31, 2021-10-29 and 2021-11-08, respectively."),
                        font = list(size = 13, color = "grey"), y = -0.4, x = -0.02, xanchor = "left",
                        xref = "paper", yref='paper', showarrow = FALSE)))
    }
    if (round_number %in% c(12)) {
      annot <- c(annot,
                 list(
                   list(text = paste0("* A correction to the UNCC-Hierbin and UTA-ImmunoSEIRS round ",
                                      round_number, " projections was made on 2022-01-21 and 2022-01-24, respectively."),
                        font = list(size = 13, color = "grey"), y = -0.4, x = -0.02, xanchor = "left",
                        xref = "paper", yref='paper', showarrow = FALSE)))
    }
    
    # Add annotation for the prior peak line
    if(round_number %in% c(11,12) & grepl("Incident", target)) {
      annot <- c(annot,
                 list(
                   list(text = paste0("Prior Peak: ",
                                      format(prior_peak_value[,value], big.mark = ",", scientific = FALSE),
                                      " (",
                                      prior_peak_value[,time_value],")"
                                      ),
                        font = list(size=8, color="red"), y=prior_peak_value[,value], x=as.Date("2021-10-15"), showarrow=TRUE)
                 ))
    }
  }
  
  # Plot (zoom-in)
  if (gs_target == "cumulative_hospitalization") {
    min_x <- pred_date
    max_x <- max(model_visual$target_end_date, na.rm = TRUE)
    min_y <- - 1000
    max_y <- max(model_visual$point, na.rm = TRUE) * 1.2
  } else {
    if (!is.null(scen_sel)) {
      gs_visual_6m <- filter(gs_visual,
                             time_value > (pred_date - period(6, "month")))
      min_x <- pred_date - period(6, "month")
      min_y <- min(gs_visual$value, model_visual$min, na.rm = TRUE)
      max_x <- max(model_visual$target_end_date, na.rm = TRUE)
      max_y <- max(gs_visual_6m$value, model_visual$point, na.rm = TRUE) * 1.2
    } else {
      min_x <- min(gs_visual$time_value, na.rm = TRUE)
      min_y <- min(gs_visual$value, na.rm = TRUE)
      max_x <- max(gs_visual$time_value, na.rm = TRUE)
      max_y <- max(gs_visual$value, na.rm = TRUE)
    }
    
  }
  
  # Plot -----------------------------------------------------------------------
  
  x1_ticks <- x2_ticks <- x3_ticks <- x4_ticks <- TRUE
  if (length(scen_sel) > 2) {
    x1_ticks <- x2_ticks <- FALSE
  } 
  
  y1_ticks <- y2_ticks <- y3_ticks <- y4_ticks <- TRUE
  if (length(scen_sel) == 2 | length(scen_sel) == 4) { 
    y2_ticks <- y4_ticks <- FALSE
    }

  plot_title_text=paste0(
    "<b>Projected ",
    y_name_title,
    " by Epidemiological Week and by Scenario for Round ", round_number, " - ", loc,"</b><br>",
    "<sup>( - Projection Epiweek; -- Current Week",
    ")<br><br></sup>"
    )

  
  plot_model <- plot_model %>%
    layout(
      annotations = annot, updatemenus = updatemenu,
      selectdirection = "v",
      title = list(
        font = list(size = 20), 
        yanchor = "top", 
        yref= "paper",
        text = plot_title_text),
      margin = list(l = 150, r = 125, b = 250, t = 150),
      autosize = TRUE,
      yaxis = list(font = list(size = 12), matches = "y2", 
                   range = c(min_y, max_y), showticklabels = y1_ticks), 
      yaxis2 = list(matches = "y", range = c(min_y, max_y), 
                    showticklabels = y2_ticks), 
      yaxis3 = list(matches = "y", range = c(min_y, max_y), 
                    showticklabels = y3_ticks), 
      yaxis4 = list(matches = "y", range = c(min_y, max_y), 
                    showticklabels = y4_ticks),
      xaxis = list(font = list(size = 12), matches = "x2",
                   ticklen = 8, tickangle = 45, range = c(min_x, max_x), 
                   showticklabels = x1_ticks, ticks = ""), 
      xaxis2 = list(font = list(size = 12), matches = "x",
                    ticklen = 8, tickangle = 45, range = c(min_x, max_x), 
                    showticklabels = x2_ticks, ticks = ""),
      xaxis3 = list(font = list(size = 12), matches = "x", ticks = "",
                    range = c(min_x, max_x), showticklabels = x3_ticks),
      xaxis4 = list(font = list(size = 12), matches = "x",  ticks = "",
                    range = c(min_x, max_x), showticklabels = x4_ticks),
      legend = list(x = 0, xanchor = "left", y = -0.2,  orientation = "h",
                    font = list(size = 14), tracegroupgap = 15,
                    title = list(
                      text = paste0("<sup>Double-click on a model name to only display it.<br>",
                                    "Click on a model name to remove it or add it from <br> the plot display.<br>",
                                    "Zoom in the graph by click and drag (double-click <br> to zoom-out)<br></sup>", 
                                    "<br><br>"),
                      font = list(size = 14))
                   ), 
      showlegend = TRUE
      ) %>% 
    config(displaylogo = TRUE, modeBarButtonsToRemove = 
             c("lasso2d", "select2d", "toImage", "drawrect"))
  # Clean environment
  if (!is.null(dev.list())) {
   for (i in 1:dev.list()[length(dev.list())]) {
      if (!is.null(dev.list())) dev.off()
    }
  }
  # Output
  plot_model
}
