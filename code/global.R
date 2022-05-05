rm(list=ls())

# Library
library(shiny)
library(shinythemes) # for the theme of the app
library(shinycssloaders)
library(ggplot2)     # for visualization
library(purrr)       # for list management
library(stringr)     # for string management
library(dplyr)       # for data frame management
library(lubridate)   # for date
library(plotly)      # for interactive graph
library(vroom)       # for optimization
library(data.table)  # for speed
library(shinyjs)

# cache - Set the path, remove any existing files, and feed to shinyOptions
cache_path = "../app-cache"
file.remove(list.files(cache_path, full.names = T))
shinyOptions(cache = cachem::cache_disk(file.path(cache_path)))

source("R/data_scripts/data_get_global_data.R")
source("R/data_scripts/data_get_constants.R")

# Get all the gold standard data
gs_data = pull_gs_data()

# Source all the additional scripts
# Note: if these scripts are NOT organized in subfolder, then we would be able
# to remove this, as all .R files in the R/ subfolder are loaded automatically
# This automatic load is NOT recursive, so I have to load them manually
purrr::walk(list.files(path = "R", pattern = "[.]R$", recursive = TRUE), function(x) {
  print(x)
  source(paste0("R/",x))
})
