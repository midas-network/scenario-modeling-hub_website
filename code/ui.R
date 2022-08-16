# UI ---------------------------------------------------------------------------
shinyUI(
    fluidPage(
    shinyjs::useShinyjs(),

    # Theme
    theme = shinythemes::shinytheme("yeti"),

    # Visits information
    includeCSS("www/custom.css"),
    includeScript("www/main.js"),
    
    tags$head(HTML("<!-- Global site tag (gtag.js) - Google Analytics -->
             <script async src=\"https://www.googletagmanager.com/gtag/js?id=G-4R0J1296E8\"></script>
             <script>
             window.dataLayer = window.dataLayer || [];
         function gtag(){dataLayer.push(arguments);}
         gtag('js', new Date());
         gtag('config', 'G-4R0J1296E8');
         </script>")),
    br(),
    
    navbarPage(
        title = "",
        id = "navbar",
        selected = strong("Plots"),
        position = "static-top", fluid = TRUE,
        
        # Add the first panel, Plot
        tabPanel(
            strong("Plots"),
            do.call(tabsetPanel,c(
                lapply(seq(1, 15), function(x) { 
                    tabPanel(paste0("Round ", x), 
                             round_scenario_plots_row_UI(paste0("round", x)))
                    }),
                id = "rtab", type = "tabs", selected = "Round 15"
            ))
        ),
        # Add the second panel, Meta Data
        tabPanel(
            strong("Model Metadata"),
            tabsetPanel(
                tabPanel("General Model Information",
                         shinycssloaders::withSpinner(
                             tableOutput(outputId = "general_model_info"),
                             color = "#211e6b")
                ),
                tabPanel("Round 11", model_metadata_UI("round11")),
                tabPanel("Round 12", model_metadata_UI("round12")),
                tabPanel("Round 13", model_metadata_UI("round13")),
                tabPanel("Round 14", model_metadata_UI("round14")),
                tabPanel("Round 15", model_metadata_UI("round15")),
                selected = "General Model Information"
            )
        ),

        # Add the third panel, Scenario Definitions
        tabPanel(
            strong("Scenario Definitions"),
            do.call(tabsetPanel,c(
                lapply(seq(1, 15), function(x) {
                    scenario_defintions_UI(paste0("round", x, "_def"))
                    }),
                selected = "Round 15"
            ))
        )
    ) # End Nav Page
    ) # End Fluid Page

) # End UI

