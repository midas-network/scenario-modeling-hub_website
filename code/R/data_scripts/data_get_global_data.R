# These functions pull various data sources


pull_gs_data <- function() {
  
  # Get the gold standard data
  g_targ = getOption("gs_targets")
  gs_path = "../visualization/data-goldstandard/"

  gs_data = lapply(g_targ[c(1,2,3,5,6)], function(x) suppressMessages(fread(paste0(gs_path,x,".csv"))))

  # Note, gs_data will include a blank data frame for cumulative hospitalizations
  gs_data[[names(g_targ)[4]]] = gs_data[[3]][0,]
  
  return(gs_data)
}

pull_model_data <- function(round_val, keep_trunc = TRUE, drop_ens = FALSE) {
  
  time <- system.time({
    
    fnames = lapply(getOption("model_targets"), function(x) {
        fread(paste0("../visualization/data-visualization/models/round",round_val,"/preprocessed_model_",x,".csv"))  
    })
    
    res = rbindlist(fnames,use.names=TRUE,idcol = "outcome")
    
    if (isTRUE(drop_ens)) {
      ens = fcase(x >=5, "Ensemble_LOP",default = "Ensemble")
      
      # Now, If more than one ensemble, we want to drop it
      ensembles_to_drop = setdiff(res[str_detect(model_name, "Ensemble"), unique(model_name)], ens)
      res <- res[!model_name %chin% ensembles_to_drop]
      
      # Update name to Ensemble (LOP) if Ensemble_LOP
      res[model_name=="Ensemble_LOP", model_name:="Ensemble (LOP)"]
    }
    
    if(!keep_trunc & "truncated" %in% colnames(res)) res$truncated <- NULL
    
    # Change numeric columns as factor
    res[, model_name:=factor(model_name, levels=model2number, labels=names(model2number))]
    res[, scenario_id:=factor(scenario_id, levels=scenario2number, labels=names(scenario2number))]
    res[, location:=factor(location, levels=location2number, labels=names(location2number))]
    
    setnames(res, old="location", new="location_name")
  
  })
  
  cat("All model data for round", round_val, "pulled in", round(time[3],3), "seconds.\n")
  
  return(res[])

  
}


pull_zeroed_data <- function(round_val) {
  
  time <- system.time({
  
    file_outcomes = c("case","hosp","death")
    
    x_cum <- lapply(file_outcomes, function(fo) {
      df <- fread(paste0("../visualization/data-visualization/models/round",
                         round_val,"/zeroed_cum_", fo, ".csv"))
      
      if(fo == "case") {
        df[,outcome:="Cumulative Cases"]
      }
      if(fo == "hosp") {
        df[,outcome:="Cumulative Hospitalizations"]
      }
      if(fo == "death") {
        df[,outcome:="Cumulative Deaths"]
      }
      df
    })
    
    res = rbindlist(x_cum)
    
    
    # # Change numeric columns as factor
    res[, model_name:=factor(model_name, levels=model2number, labels=names(model2number))]
    res[, scenario_id:=factor(scenario_id, levels=scenario2number, labels=names(scenario2number))]
    res[, location:=factor(location, levels=location2number, labels=names(location2number))]
    setnames(res, old=c("location"), new=c("location_name"))
    
  })
  
  cat("All zeroed data for round", round_val, "pulled in", round(time[3],3), "seconds.\n")
  
  return(res[])
  
}

pull_model_information <- function(fname = "../visualization/data-visualization/models/model_description.csv") {
  df = fread(fname, select = c("model_abbr", "model_version", "methods", "team_name", "license"))
  setnames(df, new=c("Name", "Version", "Description", "Author", "License"))
  return(df)
}

