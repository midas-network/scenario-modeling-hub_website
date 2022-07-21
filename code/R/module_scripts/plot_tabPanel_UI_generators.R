# UI Plot Panel Functions

###########################################################
#This function generates the scenario plots tabPanel
###########################################################
scen_plot_panel <- function(ns) {
  tabPanel(
    "Scenario Plot",
    br(),
    fluidRow(
      column(1),
      column(
        4,
        checkboxInput(
          inputId = ns("ensemble_chkbox"), 
          label = list(HTML('<div style="font-size:14px;color:#606060;">Show Additional Ensemble</div>')),
          value = FALSE,
          width = "100%"
        )
      )
    ),
    shinycssloaders::withSpinner(
      plotlyOutput(outputId = ns("visual_scenario"), height = "100%", inline = FALSE),
      type = 8, color = "#211e6b", size = 1)
  )
}

###########################################################
#This function generates the model_specific_plots tabPanel
###########################################################
model_spec_panel <- function(ns, default_ensemble) {
  tabPanel(
    "Model Specific Plots",
    br(),
    fluidRow(
      column(
        3,
        radioButtons(inputId = ns("targ_model_spec"), label="Outcome Type", choices=c("Incident","Cumulative"), selected="Incident", inline=T)
      ),
      column(
        4,
        selectInput(inputId = ns("model_model_spec"), label="Model",
                    choices=default_ensemble,
                    selected = default_ensemble)
      ),
      column(
        4,
        br(),
        checkboxInput(
          inputId = ns("ensemble_chkbox_spec"), 
          label = 'Show Additional Ensemble',
          value = FALSE,
          width = "100%"
        )
      )
    ),
    shinycssloaders::withSpinner(
      plotlyOutput(outputId = ns("model_spec"),height="100%", inline=F),
      type = 8, color = "#211e6b", size = 1)
  )
}

###########################################################
#This function generates the scenario comparison tabPanel
###########################################################
scen_comparison_panel <- function(ns,r) {

  if(r==9) {
    tabPanel(
      "Scenario Comparison",
      br(),
      fluidRow(
        column(
          6,
          sliderInput(inputId = ns("sc_start_wk"), label="Cumulative Starting From Projection Week: ", min = 1,max=26,value=1,step = 1,width="100%",)
        )
      ),
      shinycssloaders::withSpinner(
        plotlyOutput(outputId = ns("scen_comparison"),height = "100%", inline=FALSE),
        type = 8, color = "#211e6b", size = 1)
    )
  } else {
    tabPanel(
      "Scenario Comparison",
      br(),
      shinycssloaders::withSpinner(
        plotlyOutput(outputId = ns("scen_comparison"),height = "100%", inline=FALSE),
        type = 8, color = "#211e6b", size = 1)
    )

  }
}

###########################################################
#This function generates the state deviation tabPanel
###########################################################
state_deviation_panel <- function(ns) {
  tabPanel(
    "State Deviation",
    br(),
    radioButtons(inputId = ns("scale_type_dev"), label="Y-axis Scale", choices=c("Linear"="linear","Log" = "log"),
                 selected="linear", inline=T),
    shinycssloaders::withSpinner(
      tagList(
        plotlyOutput(outputId = ns("state_deviation"),height="100%"),#, height = "100%", inline = FALSE),
        htmlOutput(outputId = ns("stdev_note"))
      ),
      type = 8, color = "#211e6b", size = 1)
    )
}

###########################################################
#This function generates the trend Maps tabPanel
###########################################################

trend_maps_panel <- function(ns, default_ensemble,r) {

  rndmax = fcase(
    r %in% c(10,13), 52,
    r %in% c(11,12), 12,
    r %in% c(14), 50,
      default = 26
  )
  
  tabPanel(
    "Trend Maps",
    br(),
    fluidRow(
      column(
        3,
        selectInput(inputId = ns("trend_model_spec"), label="Model",
                    choices=default_ensemble,
                    selected = default_ensemble)
      ),
      column(
        3,
        br(),
        checkboxInput(
          inputId = ns("ensemble_chkbox_trend"), 
          label = 'Show Additional Ensemble',
          value = FALSE,
          width = "100%"
        )
      ),
      column(
        4,
        sliderInput(inputId = ns("trend_model_extent"), label="Wks to Show Beyond Observed Data",
                    value = 6,min = 6,max = rndmax,step=1)
      ),
      column(
        2,
        actionButton(inputId = ns("trend_update_button"), "Update Map")
      )
    ),
    shinycssloaders::withSpinner(
      tagList(
        plotlyOutput(outputId = ns("quasi_map"),height="100%"),
        htmlOutput(outputId = ns("quasi_map_note"))
      ),
      type = 8, color = "#211e6b", size = 1)
  )
}

###########################################################
#This function generates the Risk Maps tabPanel
###########################################################
risk_maps_panel <- function(ns) {
  tabPanel(
    "Risk Maps",
    br(),
    shinycssloaders::withSpinner(
      tagList(
        plotlyOutput(outputId = ns("risk_map"),height="100%"),#, height = "100%", inline = FALSE),
        htmlOutput(outputId = ns("risk_map_note"))
      ),
      type = 8, color = "#211e6b", size = 1)
  )
}

###########################################################
#This function generates the Model Distribution tabPanel
###########################################################
model_distribution_panel <- function(ns,r) {

  proj_length = scen_info[rnd_num==r, unique(proj_length)]
  wk_choices = c(ceiling(proj_length/2),proj_length)
  
  # the above automatically chooses the halfway point and 
  # the end point. But for Round 10, we also want the
  # quarter way point
  if(r==10) wk_choices = c(13, wk_choices)
  
  selweek=as.character(wk_choices[1])

  tabPanel(
    "Model Distribution",
    br(),
    fluidRow(
      column(1),
      column(
        3, br(),
        checkboxInput(
          inputId = ns("ensemble_chkbox_dist"), 
          label = 'Show Additional Ensemble',
          value = FALSE,
          width = "100%"
        )
      ),
      column(3,
             radioButtons(inputId = ns("targ_model_dist"), label="Outcome Type", choices=c("Incident","Cumulative"), selected="Incident", inline=T)
      ),
      column(3,
             radioButtons(inputId = ns("wk_choice_dist"), label="Week", choices=wk_choices, selected=selweek, inline=T) # selected was "13"
      )
    ),
    shinycssloaders::withSpinner(
      plotlyOutput(outputId = ns("model_dist"), height="100%"),
      type = 8, color = "#211e6b", size = 1)
    )
}


###########################################################
#This function generates the Peak Projection Plot
###########################################################
peak_panel <- function(ns,r) {
  
  tabPanel(
    "Projection Peaks",
    br(),
    shinycssloaders::withSpinner(
      tagList(
        #plotOutput(outputId = ns("peak_plot"), height="1050px")
        plotlyOutput(outputId = ns("peak_plot"), height="100%")
        
      ),
      type = 8, color = "#211e6b", size = 1)
  )
}


###########################################################
#This function generates the overall tabSetPanel that holds
# the various plot-specific tabPanels, based on the round
# number.  This allows us to more easily generate as specific
# set of plots to include for each round.
###########################################################
generate_tabsetPanel <- function(r, ns, default_ensemble) {

  plotPanels <-list(
    "scen_plot" = scen_plot_panel(ns = ns),
    "model_spec" = model_spec_panel(ns = ns, default_ensemble = default_ensemble),
    "scen_comp" = scen_comparison_panel(ns=ns,r),
    "state_dev" = state_deviation_panel(ns=ns),
    "trend_map" = trend_maps_panel(ns=ns, default_ensemble=default_ensemble,r),
    "risk_map" = risk_maps_panel(ns=ns),
    "model_dist" = model_distribution_panel(ns=ns,r),
    "peak_plot" = peak_panel(ns=ns,r)
  )

  # customizations based on round
  if(r==1) plotPanels$scen_comp <- NULL
  if(r==8) plotPanels$scen_comp <- NULL
  if(r<11|r>12) plotPanels$peak_plot <- NULL # turn off peak plot prior to Round 11 and after Round 12

  # Now, we simply remove the names from the list of tabPanels
  # because they cannot be named (see documentation for tabsetPanel)
  names(plotPanels) <- NULL

  # add id and selected
  plotPanels$id = ns("plot_tab")
  plotPanels$selected="Scenario Plot"

  # And now use do.call (note that this is changing in a new version of shiny.
  # In that new version, we will be able to splice the list items directly
  # into tabsetPanel - https://github.com/rstudio/shiny/pull/3315)
  do.call(tabsetPanel,plotPanels)
}
