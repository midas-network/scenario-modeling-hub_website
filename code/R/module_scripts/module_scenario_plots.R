##################################################
# Function returns a set of scenario checkboxes
# with a inputId = `id', and given specifics about the 
# round (`r`) and scenario number (`s`)
##################################################
scen_checkbox_UI <- function(id, r, s, show) {
  
  scen_name = scen_info[rnd_num==r & scen_num == s]$scenario_name
  scen_val = scen_info[rnd_num==r & scen_num == s]$scenario_id
  select = scen_val
  if (show == FALSE) {
     select = FALSE
  }

  chxbox = checkboxGroupInput(
    inputId = id,
    label = NULL,
    choiceNames = list(
      HTML('<div style="font-size:14px;"><b>Scenario ',
           stringr::str_extract(scen_name, "(?<=\\()."),
           "</b></br>",
           gsub(" \\(","</br>(",scen_name) %>%
             gsub(", | \\+ ", "</br>", .),
           "</div>"
           )
      ),
    choiceValues = scen_val,
    selected = select
    )

  return(chxbox)
}

##################################################
# Function returns a set of scenario radio buttons
# with a inputId = `id`, and given specifics about the 
# round (`r`)
##################################################

scen_radiobutton_UI <- function(id, r) {
  
  scen_names = scen_info[rnd_num==r]$scenario_name
  scen_vals = scen_info[rnd_num==r]$scenario_id
  
  rdiobttns = radioButtons(
    inputId = id,
    label = NULL,
    choiceNames = lapply(scen_names, function(x) HTML('<div style="font-size:14px;">', x, '</div>')),
    choiceValues = scen_vals,
    selected = scen_vals[1],
    width="100%"
  )
  
  return(rdiobttns)
}


target_choice_label = HTML('<h4 style="color:#606060"><strong>Target:</strong></h4><h5 style="color:#606060">Each model projects six different targets</h5>')
  
##################################################
# Function returns a set of target/outcome radio
# buttons, given a round (`r`)
##################################################

target_radiobutton_UI <- function(id) {
  radioButtons(
    inputId = id, 
    label = target_choice_label,
    choiceNames = get_target_choiceNames(),
    choiceValues = get_target_choiceValues()
  )
}

##################################################
# Function returns a set of target/outcome radio
# checkboxes, given a round (`r`)
##################################################

target_checkbox_UI <- function(id) {
  checkboxGroupInput(
    inputId = id, 
    label = target_choice_label,
    choiceNames = get_target_choiceNames(),
    choiceValues = get_target_choiceValues(),
    selected = get_target_choiceValues()[1]
  )
}


#get_default_ensemble <- function(models, r) {
#  ensembles = models[str_detect(models, regex("ensemble",ignore_case = T))]
#  
#  if(length(ensembles)==1) {
#    # there is only one so that has to be the default
#    default_ensemble = ensembles
#  } else {
#    # We have more than 1 ensemble, so we choose based on round number-
#    if(r>=5) {
#      # default will be the ensemble with "lop" in name
#      default_ensemble = ensembles[str_detect(ensembles, regex("lop",ignore_case = T))]
#    } else {
#      # default will be ensemble NOT with 'lop" in name
#      default_ensemble = ensembles[str_detect(ensembles, regex("lop",ignore_case = T),negate = T)]
#    }
#  }
#  
#  return(default_ensemble)
#  
#}

#This version of the default ensemble function is based on pre-selected
#List of round numbers and specific default ensembles
get_default_ensemble_fixed <- function(r) {
  return(
    unique(scen_info[rnd_num == r, ens_default])
  )
}

# This function makes the target user input (i.e. outcomes), choice Names
get_target_choiceNames <- function(target_type = c("Incident|Cumulative", "Incident", "Cumulative")) {
  
  target_names = names(getOption("gs_targets"))
  target_type = match.arg(target_type)

  purrr::map(
    paste0(
      '<div style="font-size:14px;">',
      target_names[str_starts(target_names,target_type)],
      "</div>"),
    HTML)
}

# This function makes the target user input (i.e. outcomes), choice Values
get_target_choiceValues <- function(target_type = c("Incident|Cumulative", "Incident", "Cumulative")) {
  target_names = names(getOption("gs_targets"))
  target_type = match.arg(target_type)
  target_names[str_starts(target_names,target_type)]
}


round_scenario_plots_row_UI <- function(id) {

  #cat("\n in round_scenario_plots_UI... id is ",id,"\n")
  
  # set the namespace
  ns = NS(id)
  
  # get round number
  r = as.integer(str_extract(id,"\\d+"))
  
  # get the unique model names
  #models = unique(model_data$model_name)
  
  # get the default ensemble for this round
  default_ensemble = unique(scen_info[rnd_num == r, ens_default])
  
  # get the scenario descriptors for this round
  round_scenario_desc <- rnd_desc[[r]]

  # values for showing scenarios
  showA = TRUE
  showB = TRUE
  showC = TRUE
  showD = TRUE

  if (r==11) {
     showC=FALSE
     showD=FALSE
  }
  
  # Now we make the tagList of UI elements for this round
  tagList(
      fluidRow(
        br(),
        # This is the "sidebar".. Not a formal shiny sidebar, but a column on the left
        # That contains the user inputs for this round
        column(3, 
           h2("Model Projection", style = "color:#2d5973"),
           div("New scenario for models are defined in each round", style='font-size:18px;'),
           h3(strong(paste0("Round ",r)), style = "color:#2d5973"),
           HTML(paste0('<div style="font-size:14px;">', round_scenario_desc, '</div>')),
           br(),
           # Add scenario checkoboxes and radio buttons (originally hidden)
           column(6, scen_checkbox_UI(ns("scen_sel1"),r,1,showA), scen_checkbox_UI(ns("scen_sel3"),r,3,showC)),
           column(6, scen_checkbox_UI(ns("scen_sel2"),r,2,showB), scen_checkbox_UI(ns("scen_sel4"),r,4,showD)),
           column(12,hidden(scen_radiobutton_UI(ns("scen_radio"), r)),style='padding:0px;'),
           # separate with horizontal line
           hr(style = "border:1px solid ; border-color: #bfbfbf; margin-left:15px;margin-right:45px;margin-top:200px"),
           # Add location dropdown, with US initially selected
           selectInput(ns("location"), h4(strong("Location:"), style = "color:#606060"), 
                       choices = model_location,
                       selected = "US"),
           helpText(HTML('<div style="font-size:14px;">Special regions (American Samoa, Guam, Northern Marianas Island, Virgin Islands) not included</div>')),
           # Add target radiobuttons and checkbox group (originally hidden)
           target_radiobutton_UI(id = ns("target")),
           hidden(target_checkbox_UI(id=ns("target_chkboxes"))),
           # Add uncertainty interval radio buttons
           radioButtons(ns("pi"), label = h4(strong("Uncertainty Interval:"), style = "color:#606060"),
                        choiceNames = purrr::map(paste0('<div style="font-size:14px;">', c("None", "50 %", "95 %", "multi"), "</div>"), HTML), 
                        choiceValues = list(0, 50, 95, -1),
                        selected = -1),
           hidden(
             div(id=ns("multidesc"),"'multi' displays 95%, 90%, 80%, and 50% uncertainty intervals, shaded from lightest (95%) to darkest (50%)")
           ),
           style='margin-left:30px;margin-bottom:30px;border-right: 2px solid;border-right-color: #bfbfbf;'
           ),
        # This next column is all the individual plot tabs for this round
        if (r ==8) {
          column(8, HTML("</br></br>Round 8 is an internal training round; the results will not be published."))
	      } else if (r==10) {
	        column(8,HTML("</br></br>Due to the Omicron variant, Round 10 results are no longer pertinent."))
	      } else {
	        column(8,generate_tabsetPanel(r,ns,default_ensemble))
	      }
      ),
      hr(style = "border:1px solid ; border-color: #bfbfbf;"),
      round_summary_notes(r)
  )
  
}


#Functions for round summary notes:

get_definitions <- function(rnd_num) {
  

  defs <- function(rnd_num) {
    def1 <- list(
      h2("Definitions", style = "color:#2d5973"),
      br(),
      div(strong("NPI:"), "NonPharmaceutical Interventions (e.g. masks, social distancing)", style='font-size:16px;'),
      br(),
      div(strong("Epiweek:"), "Epidemiological Week as defined by MMWR", style='font-size:16px;')
    )
    
    if(rnd_num>=5) {
      defs <- c(
        def1,
        list(
          br(),
          div(strong("LOP:"), "Linear Opinion Pool; method used to calculate Ensemble_LOP by averaging cumulative probabilities of
a given value across submissions", style='font-size:16px;')
        )
      )
    }
    
    if(rnd_num>=8) {
      defs <- c(
        def1,
        list(
          br(),
          div(strong("LOP:"), "Linear Opinion Pool; method used to calculate Ensemble_LOP and Ensemble_LOP_untrimmed by averaging cumulative probabilities of
a given value across submissions. See Notes for more details.", style='font-size:16px;')
        )
      )
    }
    
    if (rnd_num < 5) defs <- def1
    
    return(defs)
  }
  
  base_image <- function(rnd_num) {
      includeHTML(paste0("../code/www/round", rnd_num, ".html"))
  }
             
  
  if(rnd_num < 3) {
    this_row <- fluidRow(
      column(12, defs(rnd_num)), 
      br()
    )
  }
  
  if(rnd_num >= 3) {
    this_row <- fluidRow(
      column(3, defs(rnd_num)),
      column(9, base_image(rnd_num)),
      br()
    )
  }
  
  
  return(this_row)
}

get_notes <- function(rnd_num) {
  if (rnd_num < 3) round <- "round1"
  if (rnd_num >= 3 & rnd_num < 5) round <- "round3"
  if (rnd_num >= 5 & rnd_num < 7) round <- "round5"
  if (rnd_num >= 7 & rnd_num < 8) round <- "round7"
  if (rnd_num >= 8 & rnd_num < 13) round <- "round9"
  if (rnd_num >= 13) round <- "round13"
  this_row <- fluidRow(
    column(1),
    column(10,
           HTML('<h2 style="color:#2d5973">Notes:</h2>'),
           column(6, 
                  helpText(HTML(note_info[[round]][["first_col"]])),
                  style='border-right: 2px solid;border-right-color: #bfbfbf;padding-right:25px'),
           column(5, helpText(HTML(note_info[[round]][["second_col"]])),
                  style='margin-left:50px;'), 
           style='margin-top:50px;margin-bottom:50px;border: 2px solid;border-color:#bfbfbf;padding-bottom:25px;'),
    br()
    )
  
  return(this_row)
  

}


round_summary_notes <- function(rnd_num) {
  
  defs = get_definitions(rnd_num)
  notes = get_notes(rnd_num)
  
  return(list("defs"=defs, "notes"=notes))
}

note_info <- list(
  "round1" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> The Scenario Modeling Hub ensembles individual projections using one method:', 
      "<b>Ensemble</b> is obtained by calculating the median of each submitted quantile.",
      "</br>Ensemble projection includes only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "</div>"
      ),
    "second_col"=c(
      '<div style="font-size:16px;">',
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  ),
  "round3" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> The Scenario Modeling Hub ensembles individual projections using one method:', 
      "<b>Ensemble</b> is obtained by calculating the median of each submitted quantile.",
      "</br>Ensemble projection includes only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "<u><b>Projection truncation:</b></u> Since models were not required to incorporate behavioral feedbacks that would likely accompany large increases in COVID-19 cases, hospitalizations, or deaths,",
      " we truncate projected values beyond 80% of previously seen peaks. ",
      "Within each location, truncation is evaluated separately for incident cases and deaths. ",
      "</br>The truncation threshold is calculated as 80% of the highest observed weekly incidence, adjusted by population size. ",
      "Once either threshold is crossed, all projections (incident and cumulative case, death, and hospitalization) are truncated using following the following rules:</br></br>",
      "</div>"
    ),
    "second_col" = c(
      '<div style="font-size:16px;">',
      "&emsp;&emsp;- If an individual model projects incident cases or deaths to be higher than the threshold, median projections are not plotted for that model beyond the week at which the threshold is crossed.",
      " Uncertainty intervals are retained for all weeks. ",
      "This truncation is applied to all states, except those for which truncation would remove all projection points.</br>", 
      "&emsp;&emsp;- If the Ensemble crosses the threshold, no projections (median or uncertainty intervals) are plotted beyond the first week at which the threshold is crossed.</br></br> ",
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  ),
  "round5" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> Currently, the Scenario Modeling Hub ensembles individual projections using two methods:', 
      "</br>(a) <b>Ensemble_LOP</b> is calculated by averaging cumulative probabilities of a given value across submissions. ",
      "</br>(b) <b>Ensemble</b> is obtained by calculating the median of each submitted quantile.",
      "</br>Ensembles projection include only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "<u><b>Projection truncation:</b></u> Since models were not required to incorporate behavioral feedbacks that would likely accompany large increases in COVID-19 cases, hospitalizations, or deaths,",
      " we truncate projected values beyond 80% of previously seen peaks. ",
      "Within each location, truncation is evaluated separately for incident cases and deaths. ",
      "</br>The truncation threshold is calculated as 80% of the highest observed weekly incidence, adjusted by population size. ",
      "Once either threshold is crossed, all projections (incident and cumulative case, death, and hospitalization) are truncated using following the following rules:</br></br>",
      "</div>"
    ),
    "second_col" = c(
      '<div style="font-size:16px;">',
      "&emsp;&emsp;- If an individual model projects incident cases or deaths to be higher than the threshold, median projections are not plotted for that model beyond the week at which the threshold is crossed.",
      " Uncertainty intervals are retained for all weeks. ",
      "This truncation is applied to all states, except those for which truncation would remove all projection points.</br>", 
      "&emsp;&emsp;- If the LOP Ensemble crosses the threshold, no projections (median or uncertainty intervals) are plotted beyond the first week at which the threshold is crossed.</br></br> ",
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  ),
  "round7" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> Currently, the Scenario Modeling Hub ensembles individual projections using two methods:', 
      "</br>(a) <b>Ensemble_LOP</b> is calculated by averaging cumulative probabilities of a given value across submissions. ",
      "</br>(b) <b>Ensemble</b> is obtained by calculating the median of each submitted quantile.",
      "</br>Ensembles projection include only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "</div>"
    ),
    "second_col" = c(
      '<div style="font-size:16px;">',
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  ),
  "round9" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> Currently, the Scenario Modeling Hub ensembles individual projections using two methods:', 
      "</br>(a) <b>Ensemble_LOP</b> is calculated by averaging cumulative probabilities of a given value across submissions.  At each value, the highest and lowest probability is removed before averaging. ",
      "</br>(b) <b>Ensemble_LOP_untrimmed</b> is calculated by averaging cumulative probabilities of a given value across submissions.  All values are included in the average. ",
      "</br>(c) <b>Ensemble</b> is obtained by calculating the median of each submitted quantile.",
      "</br>Ensembles projection include only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "</div>"
    ),
    "second_col" = c(
      '<div style="font-size:16px;">',
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  ),
  "round13" = list(
    "first_col" = c(
      '<div style="font-size:16px;"><u><b>Ensemble methods:</b></u> Currently, the Scenario Modeling Hub ensembles individual projections using two methods:', 
      "</br>(a) <b>Ensemble_LOP</b> is calculated by averaging cumulative probabilities of a given value across weighted submissions. At each value, the highest and lowest probability is removed before averaging. ",
      "</br>(b) <b>Ensemble_LOP_untrimmed</b> is calculated by averaging cumulative probabilities of a given value across weighted submissions. All values are included in the average.",
      "</br>(c) <b>Ensemble</b> is obtained by calculating the weighted median of each submitted quantile.",
      "</br>Ensembles projection include only those submissions that reported all quantiles and the four scenarios for their targets.",
      'Individual model and ensemble projections are available in the <a href=https://github.com/midas-network/covid19-scenario-modeling-hub target-"blank">GitHub Repository</a>. </br></br>',
      "<u><b>Ground truth data:</b></u> The model projections for cumulative hospitalizations start at zero, so no observed data are shown. </br></br>",
      "</div>"
    ),
    "second_col" = c(
      '<div style="font-size:16px;">',
      "<u><b>Licensing:</b></u> Models projection are available by default under a CC BY 4.0 license. Some models have specific license. See repository for details.</br></br>",
      "<u><b>Disclaimer:</b></u> The content of the COVID-19 Scenario Modeling Hub is solely the responsability of the participating teams and the Hub maintainers and does not represent the official views ",
      "of any related funding organizations</div>"
    )
  )
)

##############################################################
## SERVER SIDE LOGIC

# dynamic server modules

scenario_plots_server <- function(id, tab_data=NULL) {
  
  moduleServer(
    id, 
    function(input, output, session) {
      
      # Let's make a note of which plot tab we are on!
      current_plot_tab <- reactive(input$plot_tab)
      
      # get round number
      r = as.integer(str_extract(id,"\\d+"))
      
      # get default ensemble
      def_ens <- unique(scen_info[rnd_num == r, ens_default])
      ens_exc <- unique(scen_info[rnd_num == r, ens_excl])

      # When this plot tab changes (we observe it here ...)
      # we want to hide/show certain UI elements.. Since
      # this update is complicated, we push to function:
      # update_sidebar_inputs()
      observeEvent(
        current_plot_tab(),{
          update_sidebar_inputs(
            pt = current_plot_tab(), 
            model_names = grep(ens_exc, unique(
              tab_data()$model_data$model_name), value = TRUE, 
              invert = TRUE),
            default_ensemble = def_ens,
            input = input,
            session = session,
            r = r)
          # update the ensemble checkbox
          if (r > 4) {
            updateCheckboxInput(session, "ensemble_chkbox_spec", value = FALSE)
            updateCheckboxInput(session, "ensemble_chkbox_trend", value = FALSE)
          }
          # update the dropdown for Trend map
          updateSelectizeInput(session, "trend_model_spec", choices=grep(ens_exc, unique(
            tab_data()$model_data$model_name), value = TRUE, 
            invert = TRUE), selected=def_ens)
          # trigger a click to update value 
          shinyjs::click("trend_update_button")
       })
      
      show_ens_spec <- reactive(input$ensemble_chkbox_spec)
      
      if (!(r %in% c(8, 10))) {
        observeEvent(
          show_ens_spec(), {
            update_sidebar_inputs(
              pt = current_plot_tab(), 
              model_names = if (isFALSE(show_ens_spec())) grep(ens_exc, unique(
                tab_data()$model_data$model_name), value = TRUE, 
                invert = TRUE) else unique(tab_data()$model_data$model_name),
              default_ensemble = def_ens,
              input = input,
              session = session,
              r = r)
          })
        }
      
      show_ens_trend <- reactive(input$ensemble_chkbox_trend)
      
      if (!(r %in% c(8, 10))) {
        observeEvent(
          show_ens_trend(), {
            update_sidebar_inputs(
              pt = current_plot_tab(), 
              model_names = if (isFALSE(show_ens_trend())) grep(ens_exc, unique(
                tab_data()$model_data$model_name), value = TRUE, 
                invert = TRUE) else unique(tab_data()$model_data$model_name),
              default_ensemble = def_ens,
              input = input,
              session = session,
              r = r)
          })
      }
      
      ta <- reactive(input$target)
      lo <- reactive(input$location)
      ss <- reactive({
        c(input$scen_sel1, input$scen_sel2, input$scen_sel3, input$scen_sel4)
        
      })
      
      # get the radio button scenario selection
      scen_radio = reactive(input$scen_radio)
      
      # get the target checkbox selection(s)
      ta_chk = reactive(input$target_chkboxes)
      
      # Get the ensemble checkbox selection
      show_ens <- reactive(input$ensemble_chkbox)
      ens_chk = reactive(input$ensemble_chkbox_dist)
      
      # get the uncertainty level input
      pi <- reactive(input$pi)

      # get the scale type for state deviation
      scale_type_dev = reactive(input$scale_type_dev)
      
      # get the week choice input selector
      wk_dist = reactive(input$wk_choice_dist)
      
      # get the scen comparison start week selector
      sc_start_wk = reactive(input$sc_start_wk)
      
      model_spec_target_types = reactive(input$targ_model_spec)
      model_dist_target_types = reactive(input$targ_model_dist)
      model_model_name = reactive(input$model_model_spec)
      
      trend_model_name = reactive(input$trend_model_spec)
      trend_model_extent = reactive(input$trend_model_extent)
      # wrap these in eventReactive
      trend_map_choices = eventReactive(input$trend_update_button,{
        list("name" = trend_model_name(),
             "extent" = trend_model_extent())
      },ignoreNULL = FALSE)
      
      #' ########################################################
      #' BASIC SCENARIO VISUALIZATION
      #' ########################################################
      
      output$visual_scenario <- renderPlotly({
        server_plot(tab_data()$model_data, ta(), lo(), ss(), pi(), id, show_ens())
      }) %>% bindCache("visscen", ta(), lo(), ss(), pi(), id, show_ens())
      
      #' ########################################################
      #' MODEL SPECIFIC VISUALIZATION
      #' ########################################################
      output$model_spec <- renderPlotly({
        create_model_specific_plotly(model_data = tab_data()$model_data, 
                                     location = lo(),
                                     rtab = id, 
                                     target_type = model_spec_target_types(),
                                     model_name = model_model_name(),
                                     pi=pi())
        
      }) %>% bindCache("modspec", lo(), id, model_spec_target_types(), model_model_name(), pi())
      
      #' ######################################################## 
      #' SCENARIO COMPARISON
      #' ########################################################
      
      output$scen_comparison <- renderPlotly({
        scen_comp_data <- tab_data()$scen_com
        if(!is.null(scen_comp_data)) {
          if(r == 9) {
            create_scenario_comparison_plotly(scen_comp_data[week==sc_start_wk()-1], loc_name = lo())
          } else {
            if(r>=7) create_scenario_comparison_plotly(scen_comp_data[week==0], loc_name = lo())
            else create_scenario_comparison_plotly(scen_comp_data, loc_name = lo())
          }
        }
      }) %>% bindCache("comp", sc_start_wk(), lo(),id)
      
      #' ########################################################
      #' STATE DEVIATION
      #' ########################################################
      #output$stdev_note <- renderUI(scenario_selector_note)
      output$state_deviation <- renderPlotly({
        
        if(!ta() %in% c("Incident Cases", "Incident Hospitalizations", "Incident Deaths")) {
          return(NULL)
        }
        
        st_deviation_data <- tab_data()$st_dev
        if(!is.null(st_deviation_data)) {
          create_state_variation_plotly(
            state_variation_data = st_deviation_data,
            scen = scen_radio(),
            scale_type = scale_type_dev(),
            outcome_choice = ta()
          )
        }
      }) %>% bindCache("dev", scale_type_dev(), ta(), scen_radio(), id)
      
      #' ########################################################
      #' RISK MAP
      #' ########################################################
      #output$risk_map_note <- renderUI(scenario_selector_note)
      output$risk_map <- renderPlotly({
        
        if(!ta() %in% c("Cumulative Cases", "Cumulative Hospitalizations", "Cumulative Deaths")) {
          return(NULL)
        }
        
        risk_data <- tab_data()$risk_data
        if(!is.null(risk_data)) {
          if(r>=7) {
            create_risk_map_zero_plotly(risk_data,scen = scen_radio(),outcome_choice = ta())
          } else {
            create_risk_map_plot_plotly(risk_data,scen = scen_radio(),outcome_choice = ta())  
          }
          
        }
      }) %>% bindCache("risk", scen_radio(), ta(), id)
      
      #' ########################################################
      #' QUASI MAP
      #' ########################################################
      #output$quasi_map_note <- renderUI(scenario_selector_note)
      output$quasi_map <- renderPlotly({
        
        if(!ta() %in% c("Incident Cases", "Incident Hospitalizations", "Incident Deaths")) {
          return(NULL)
        }
        
        quasi_data <- get_quasi_map_data(
          rnd_num = r,
          model_data = tab_data()$model_data,
          model_to_show = trend_map_choices()$name,
          forward = trend_map_choices()$extent
        )
          
        if(!is.null(quasi_data)) {
          create_quasi_map(quasi_data,scen = scen_radio(),target_outcome = ta())
        }
      }) %>% bindCache("quasi", scen_radio(), ta(), trend_map_choices()$name, trend_map_choices()$extent,id)

      #' ########################################################
      #' MODEL DISTRIBUTION / BOXPLOTS
      #' ########################################################
      
      output$model_dist <- renderPlotly({
        
        dist_data <- tab_data()$model_data
        
        if(!is.null(dist_data)) {
          create_model_dist_plotly(dist_data,location=lo(),
                                   wk = as.integer(wk_dist()),
                                   outcome_type = model_dist_target_types(),
                                   scenarios = ss(),
                                   rd_num = r,
                                   ens_chk = ens_chk())
        }
      }) %>% bindCache("dist", model_dist_target_types(), lo(), wk_dist(), id, ss(), ens_chk())
      
      #' ########################################################
      #' PROJECTION PEAKS
      #' ########################################################
      
      output$peak_plot <- renderPlotly({
        
        peak_data <- get_peak_period_data(rnd=r,model_data = tab_data()$model_data)

        if(!is.null(peak_data)) {
          create_peak_plotly(
            peak_data = peak_data,
            scen_sel = ss(),
            outcomes = ta_chk()
            #make_plotly = F
          )
        }
      }) %>% bindCache("peak", ss(), ta_chk(), id)
      
    }
  )
  
}


