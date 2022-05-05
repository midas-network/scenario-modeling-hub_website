# Define server logic ----------------------------------------------------------
shinyServer(function(input, output, session) {
  
  tab_data <- eventReactive(input$rtab,{
    r = as.integer(str_extract(input$rtab,"\\d+"))

    ens <- get_default_ensemble_fixed(r)
    model_data = pull_model_data(round = r, keep_trunc = T, drop_ens = FALSE)
    
    # grab zeroed out data if round>=7
    if(r>=7) {
      zc_data = pull_zeroed_data(round_val = r)
      risk_map_data = get_risk_map_data_zero(
        rnd=r,
        zeroed_data=zc_data,
        ensemble=ens)
      
      
      # Set the end week to be the max target_wk.. However, this is not going to work
      # if we have some zeroed out data for individual models have different end points (for example,
      # if one of the models has 52, then this scenario comparison needs to be consitent)
      # Therefore, one way around this is to reduce the zc_data to have target_wk less than
      # or equal to the max endweek of the default ensemble for this round
      
      endweek = max(zc_data[model_name==ens, target_wk])
      scen_comp_data = get_scen_comp_data(r,zc_data[target_wk<=endweek],"zero_cum",endweek=endweek)
      
      
    } else {
      risk_map_data = get_risk_map_data(r,model_data)
      scen_comp_data = get_scen_comp_data(r,model_data,method="sum_incidence")
    }
    
    gc()
    
    output <- list(
      "scen_com" = scen_comp_data, 
      "st_dev" = get_variation_data(r, model_data),
      "risk_data" = risk_map_data,
      "model_data" = model_data
    )
    return(output)
  })
  
  ## Scenario Plots -------------------
  for(i in seq(1,13)) {
    rndstr = paste0("round",i)
    scenario_plots_server(rndstr,reactive(tab_data()))
    model_metadata_server(rndstr)
  }

  ## Description of the Models -------------------
  output$general_model_info <- renderTable({pull_model_information()})
  
})
