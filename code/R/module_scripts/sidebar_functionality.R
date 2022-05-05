## Server Side Update Function for Side Bar Inputs
# This function receives the name of the current plot
# and tries to run some shinyJS to hide/show etc, 
# or modifies the input, etc
# `pt` is the string name of the plot tab
# `r` is the round number

update_sidebar_inputs <- function(pt, model_names, default_ensemble, input, session, r) {
  
  update_chooser <- list(
    "Scenario Plot" = sidebar_for_scenario_plot,
    "Model Specific Plots" = sidebar_for_model_specific,
    "Scenario Comparison" = sidebar_for_scenario_comparison,
    "State Deviation" = sidebar_for_state_deviation,
    "Trend Maps" = sidebar_for_trend_maps, 
    "Risk Maps" = sidebar_for_risk_maps,
    "Model Distribution" = sidebar_for_model_distribution,
    "Projection Peaks" = sidebar_for_peak_plot
  )
  if(pt %in% names(update_chooser)) {
    update_chooser[[pt]](input=input, session=session, model_names=model_names, default_ensemble=default_ensemble, r = r)
  } else {
    print(paste0("No sidebar update function for this plot tab: ", pt))
  }
  
  
}

sidebar_for_scenario_plot <- function(input, session,r,...) {
  
  #hide the radio button selector for scenario
  hide("scen_radio")
  
  #show description of multi if round ==11
  if(r>=11) {
    show("multidesc")
  }
  #show the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), show)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  
  #enable all inputs
  purrr::walk(c("location", "target", "scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "pi"), enable)
  
  # Since target is enabled, make sure all choices are there
  updateRadioButtons(
    session, "target",choiceNames = get_target_choiceNames(), choiceValues = get_target_choiceValues()
  )
  
  # update the choices for model_specific PI intervals
  pi_options = list("names" = c("None", "50 %", "95 %"), "values" = list(0,50,95))
  
  if(r>=11) {
    pi_options[["names"]] = c(pi_options[["names"]], "multi")
    pi_options[["values"]] = list(0,50,95,-1)
  }
  
  updateRadioButtons(
    session, "pi", 
    choiceNames = purrr::map(paste0('<div style="font-size:14px;">', pi_options[["names"]], "</div>"), HTML), 
    choiceValues = pi_options[["values"]],
    selected = ifelse(r>=11,-1,95) ##Make default multi-mode when round is 11, 95% otherwise. 
  )
  
  
  
}

sidebar_for_model_specific <- function(input, session,model_names, default_ensemble,...) {
  
  #hide the radio button selector for scenario
  hide("scen_radio")
  hide("multidesc")
  
  #show the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), show)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  
  purrr::walk(c("target", "scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), disable)
  
  purrr::walk(c("pi", "location"), enable)
  
  # update the choices for model_specific PI intervals
  pi_options = list("names" = c("None", "50 %", "95 %"), "values" = list(0,50,95))
  
  updateRadioButtons(
    session, "pi", 
    choiceNames = purrr::map(paste0('<div style="font-size:14px;">', pi_options[["names"]], "</div>"), HTML), 
    choiceValues = pi_options[["values"]],
    selected = 95
  )
  
  # update the dropdown
  updateSelectizeInput(session, "model_model_spec", choices=model_names, selected=default_ensemble)
  
  
}

sidebar_for_scenario_comparison <- function(input, session,...) {
  
  #hide the radio button selector for scenario
  hide("scen_radio")
  #show the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), show)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  #disable most of the ui elements
  purrr::walk(c("target", "scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "pi"), disable)
  enable("location")
}

sidebar_for_state_deviation <- function(input, session,...) {
  
  #hide the radio button selector for scenario
  show("scen_radio")
  #hide the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), hide)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  
  # disable the location, prediction intervals
  purrr::walk(c("location", "pi"), disable)
  # enable the rest
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "target"), enable)
  
  # Limit the outcome choices to Incident only
  updateRadioButtons(
    session, "target", 
    choiceNames = get_target_choiceNames("Incident"),
    choiceValues = get_target_choiceValues("Incident")
  )
  
}

sidebar_for_trend_maps <- function(input, session,model_names, default_ensemble,...) {
  
  #show the radio button selector for scenario
  show("scen_radio")
  #hide the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), hide)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  
  # disable the location, prediction intervals
  purrr::walk(c("location", "pi"), disable)
  # enable the rest
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "target"), enable)
  
  # Limit the outcome choices to Incident only
  updateRadioButtons(
    session, "target", 
    choiceNames = get_target_choiceNames("Incident"),
    choiceValues = get_target_choiceValues("Incident")
  )
  
  # update the dropdown
  updateSelectizeInput(session, "trend_model_spec", choices=model_names, selected=default_ensemble)
  
}
sidebar_for_risk_maps <- function(input, session,...) {
  
  #show the radio button selector for scenario
  show("scen_radio")
  #hide the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), hide)

    # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  
  # disable the location, prediction intervals
  purrr::walk(c("location", "pi"), disable)
  # enable the rest
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "target"), enable)
  
  # Limit the outcome choices to Cumulative only
  updateRadioButtons(
    session, "target", 
    choiceNames = get_target_choiceNames("Cumulative"),
    choiceValues = get_target_choiceValues("Cumulative")
  )
  
}
sidebar_for_model_distribution <- function(input, session,...) {
  
  #hide the radio button selector for scenario
  hide("scen_radio")
  
  #show the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), show)
  
  # hide the target checkboxes and show the target radiobuttons instead
  show("target")
  hide("target_chkboxes")
  
  # disable the target, prediction intervals
  purrr::walk(c("target", "pi"), disable)
  
  # enable the rest
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "location"), enable)
  
  
  
}

sidebar_for_peak_plot <- function(input, session,r,...) {
  
  #hide the radio button selector for scenario
  hide("scen_radio")
  
  #show the regular scenario selector
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4"), show)
  
  # hide the target radios and show the target checkboxes instead
  hide("target")
  
  # disable the prediction intervals and location
  purrr::walk(c("pi","location"), disable)
  
  # enable the rest
  purrr::walk(c("scen_sel1", "scen_sel2", "scen_sel3", "scen_sel4", "target_chkboxes"), enable)
  
  # Limit the outcome choices to Incident Only
  updateCheckboxGroupInput(
    session, 
    "target_chkboxes", 
    choiceNames = get_target_choiceNames("Incident"),
    choiceValues = get_target_choiceValues("Incident"),
    selected=get_target_choiceValues("Incident")[1]
  )
  show("target_chkboxes")

  
  
  
}
