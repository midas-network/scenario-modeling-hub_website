# # ======================================
# # Functions to get plot input data
# # ======================================
# 
# # First, a function for the gold standard data
# 
# get_gs_visual_data <- function(target, location, rtab)  {
#   # Get the target outcome, and filter on location
#   
#   gs_visual <- gs_data[[target]]
#   gs_visual <- gs_visual[geo_value_fullname == location]
#   
#   return(gs_visual)
# }
# 
# # ======================================
# # Next a function to pull the model data
# # ======================================
# get_model_visual_data <- function(model_data, outcome_name, location, scen_sel, pi, rtab) {
#   
#   rtab_number= as.numeric(str_extract(rtab,"\\d+"))
#   model_visual <- model_data[
#     location_name==location & scenario_id %chin% scen_sel & outcome == outcome_name]
#   
#   # Date of prediction use for filtering and for gray vertical line
#   pred_date = fifelse(rtab_number==1, as.Date("2021-01-02"), as.Date(model_visual[,min(target_end_date)] - 7))
#   
#   # if model_visual has column named truncated, then we should drop the rows that are truncated
#   if("truncated" %in% colnames(model_visual)) {
#     model_visual <- model_visual[truncated==0]
#   }
#   
#   return(list("model_visual" = model_visual, "pred_date" = pred_date))
#   
# }
# 
# # ======================================
# # A function to pivot model data visual to wide format
# # ======================================
# pivot_model_visual <- function(model_visual, pi) {
# 
#   
#   # if there are no row, just return the empty frame
#   if (dim(model_visual)[1] > 0)  {
#     # Get the lower and upper bounds
# 
#     pi = as.integer(pi)
#     pi_bounds = list("lower" = (1-pi/100)/2, upper=1-(1-pi/100)/2)
#     
#     
#     
#     # Select Projection Intervals
#     if(pi!=0) {
#       model_visual <- model_visual[
#         dplyr::near(quantile, pi_bounds[["lower"]]) |
#           dplyr::near(quantile, pi_bounds[["upper"]]) |
#           is.na(quantile)
#         ]
#       
#       model_visual[,quantile:=fcase(
#         is.na(quantile), "point",
#         dplyr::near(quantile, pi_bounds[["lower"]]),"min",
#         default = "max")]
#       
#       # drop any type/trunc variables
#       dropvars = str_detect(names(model_visual), pattern="type|trunc")
#       model_visual <- model_visual[, !..dropvars]
#       
#       # swing wide
#       model_visual <- dcast(model_visual, ... ~ quantile, value.var="value")
#       model_visual <- model_visual[!is.na(min) & !is.na(max)]
#     } else {
#       # just take the point rows
#       model_visual = model_visual[type=="point"]
#       dropvars = str_detect(names(model_visual), pattern="quantile|type|trunc")
#       model_visual <- model_visual[, !..dropvars]
#       setnames(model_visual, old="value", new="point")
#     }
#     
#   }
# 
#   return(model_visual)
# }
# 
# 
# # Fast wrapper function, given shiny inputs
# prepare_plot_data <- function(target, location, scen_sel,pi,rtab) {
#   
#   # Model Data, using function in get_visual_data_inputs.R
#   model_result <- get_model_visual_data(target, location, scen_sel, pi, rtab)
#   model_visual <- model_result[["model_visual"]]
#   pred_date <- model_result[["pred_date"]]
# 
#   
#   gs_target = getOption("gs_targets")[[target]]
#   
#   # GOLD STANDARD DATA, using function in get_visual_Data_inputs.R
#   gs_visual <- get_gs_visual_data(target, location, rtab) 
#   # Filter to the past six months, using the pred_date
#   gs_visual <- gs_visual[time_value > (pred_date - lubridate::period(6, "month"))]
#   # Set a model name variable
#   gs_visual[,model_name:="Observed"]
#   
#   
#   # Swing the model_visual wide, depending on desired pi
#   model_visual <- pivot_model_visual(model_visual, pi)
#   
#   ## Restrict visual to 26 weeks projections
#   if(!"target_wk" %in% colnames(model_visual)) {
#     model_visual <- model_visual[, target_wk:=as.numeric(str_extract(target,"^[0-9]*(?= )"))]
#   }
#   model_visual <- model_visual[target_wk<27]
#   
#   
#   return(list("model_visual" = model_visual[order(scenario_id, model_name, target_wk)],
#               "gs_visual" = gs_visual,
#               "pred_date" = pred_date)
#   )
#   
# }
# 
