# Get Informative Constants

# Today/s week
wtoday <- as.Date(paste0(lubridate::epiyear(Sys.time()), "-",
                         lubridate::epiweek(Sys.time()), "-1"), "%Y-%U-%u") + 5


# Get the location information, with population
locations <- fread("../data-locations/locations.csv")

load("../visualization/data-visualization/sysdata.rda")

#Make lookup table of round, scenario information
# lets make an adjustment to scenario_name vector (has a non-necessary " Increase" embedded)
#scenario_name <- lapply(scenario_name, function(x) str_remove(x," Increase"))

scen_info <- data.table(
  scenario_id = scenario_sel,
  scen_num = fcase(
    str_detect(scenario_sel,"A"),1,
    str_detect(scenario_sel,"B"),2,
    str_detect(scenario_sel,"C"),3,
    str_detect(scenario_sel,"D"),4
  ),
  rnd_num = as.numeric(gsub("[[:alpha:]]", "", names(scenario_sel))),
  scenario_name = scenario_name, 
  scen_title = str_replace(scenario_name, paste0(" \\(",scenario_sel,"\\)"), "")
)


rnd_desc = list("Scenario defined as of 2020-12-22</br>Model Projecting from Epiweek 53 to Epiweek 26 ",
                "Scenario defined as of 2021-01-22</br>Model Projecting from Epiweek 3 to Epiweek 29 ",
                "Scenario defined as of 2021-03-05</br>Model Projecting from Epiweek 9 to Epiweek 35 ",
                "Scenario defined as of 2021-03-28</br>Model Projecting from Epiweek 12 to Epiweek 38 ",
                "Scenario defined as of 2021-05-02</br>Model Projecting from Epiweek 17 to Epiweek 43 ",
                "Scenario defined as of 2021-05-25</br>Model Projecting from Epiweek 21 to Epiweek 47 ",
                "Scenario defined as of 2021-07-06</br>Model Projecting from Epiweek 27 to Epiweek 52 ",
                "Scenario defined as of 2021-08-02</br>Model Projecting from Epiweek 33 to Epiweek 6 ",
                "Scenario defined as of 2021-08-30</br>Model Projecting from Epiweek 36 to Epiweek 9 ",
                "Scenario defined as of 2021-10-27</br>Model Projecting from Epiweek 46 to Epiweek 45 ",
                "Scenario defined as of 2021-12-13</br>Model Projecting from Epiweek 51 to Epiweek 10",
                "Scenario defined as of 2022-01-09</br>Model Projecting from Epiweek 2 to Epiweek 13",
                "Scenario defined as of 2022-02-22</br>Model Projecting from Epiweek 11 to Epiweek 11",
                "Scenario defined as of 2022-05-17</br>Model Projecting from Epiweek 23 to Epiweek 23",
                "Scenario defined as of 2022-07-22</br>Model Projecting from Epiweek 31 to Epiweek 18")
scen_info[, rnd_tab := paste0("Round ",rnd_num)]

scen_info[, ens_default := case_when(
  rnd_num < 5 ~ "Ensemble",
  rnd_num > 4 & rnd_num < 13 ~ "Ensemble_LOP",
  rnd_num >= 13 ~ "Ensemble_LOP_untrimmed"
)]

scen_info[, ens_excl := case_when(
  rnd_num < 5 ~ "ZZZZZZZZZZ",
  rnd_num > 4 & rnd_num < 13 ~ "^Ensemble_LOP_untrimmed$|^Ensemble$",
  rnd_num >= 13 ~ "^Ensemble_LOP$|^Ensemble$"
)]

scen_info[, proj_length:=fcase(
  rnd_num%in%c(10,13),52,
  rnd_num%in%c(14),50,
  rnd_num%in%c(15),40,
  rnd_num %in% c(11,12),12,
  default=26
)]


options(model_targets =  c(
  "Incident Cases" = "inc_case",
  "Cumulative Cases" = "cum_case",
  "Incident Hospitalizations" = "inc_hosp",
  "Cumulative Hospitalizations" = "cum_hosp",
  "Incident Deaths" = "inc_death",
  "Cumulative Deaths" = "cum_death"
))

# GOLD STANDARD DATA
options(gs_targets = c(
  "Incident Cases" = "confirmed_incidence_num",
  "Cumulative Cases" = "confirmed_cumulative_num",
  "Incident Hospitalizations" = "hospitalization",
  "Cumulative Hospitalizations" = "cumulative_hospitalization",
  "Incident Deaths" = "deaths_incidence_num",
  "Cumulative Deaths" = "deaths_cumulative_num"
))
# unit
options(units =  c(
  "Incident Cases" = "k",
  "Cumulative Cases" = "M",
  "Incident Hospitalizations" = "k",
  "Cumulative Hospitalizations" = "k",
  "Incident Deaths" = "k",
  "Cumulative Deaths" = "M"
  
))

