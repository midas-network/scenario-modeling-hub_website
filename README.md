# Website of COVID-19 Scenario Modeling Hub

The [Covid-19 Scenario Modeling
Hub](https://covid19scenariomodelinghub.org) is a community infectious
disease modeling effort. Scenario modeling hub teams construct
medium-term (6-12 months) projections of possible trajectories of the
COVID-19 pandemic under specified possible futures, including the
impact of waning vaccine efficacy, childhood vaccinations, and new
variants, among others.

This repository contains the source code and the data used to generate the 
Shiny App for the Projections visualization of the [COVID-19 Scenario Modeling Hub website](https://covid19scenariomodelinghub.org/). 

## Description

The repository is separated into three principal folders:

* `code` containing the R scripts for the Shiny App.
* `data-locations` containing location and population size information.
* `visualization` containing all the output data used for the visualization.

### R scripts (`code`)

This folder contains the code used to generate the Shiny App for the projections
visualization on the  
[Scenario Modeling Hub website Projections](https://covid19scenariomodelinghub.org/viz.html).

The folder is separated in multiple script and subfolders:
* The three R scripts: `global.R`, `server.R` and `ui.R` are the scripts 
defining the Shiny App.  They contains the code for the server and user 
interface part of the Shiny App and also the code to load some variables in the 
environment.
* The `www` folder contains the CSS, JS codes and different HTML tables used 
in the website
* The `R` folder contains multiple scripts: 
  * `data_scripts`: scripts used to load constant variables and the data in 
the environment of the Shiny App.
  * `module_scripts`: the Shiny App used module to manage the repetition of 
rounds. The modules codes are stored in this folder.
  * `plot_scripts`: contains script for each plot displayed on the Shiny App 
plus some "helping" functions used by these plots.

To run the Shiny App locally, you can run the script `global.R` from the folder
`code\`.

### Locations (`data-locations`)

The projections are expressed by location for the US States and at the 
national level. The submission files use the FIPS codes
associated with each location. The `locations.csv` files contains the
state names, associated FIPS codes and population sizes that are
used by the teams for coding the location information.

### Visualization data (`visualization/`)

All the data used on the website are stored in this folder. The folder is 
divided in multiple sub folders containing the "ground truth" data (also called 
gold standard data), the model projections from the teams plus the ensembles, 
the metadata information associated with each projection, and the scenario 
information for each round.

The data are generated internally from the projection submitted by the 
team and available on the [Scenario Modeling Hub Github](https://github.com/midas-network/covid19-scenario-modeling-hub). 
Currently, the Scenario Modeling Hub generates 3 ensembles projections using 
three methods: 

1.  Ensemble_LOP (LOP:Linear Opinion Pool) is calculated by averaging
cumulative probabilities of a given value across submissions. At each
value, the highest and lowest probability is removed before
averaging.

2. Ensemble_LOP_untrimmed is calculated by averaging cumulative
probabilities of a given value across submissions. All values are
included in the average.

3. Ensemble is obtained by calculating the median of each submitted quantile. 

#### - Gold standard data (`visualization/data-goldstandard`)

We use the daily reports containing COVID-19 cases and deaths data
from the [JHU CSSE group](https://coronavirus.jhu.edu/map.html) as the
gold standard reference data for cases and deaths in the US. We use
the distribution of the JHU data as provided by the 
[COVIDcast Epidata API](https://cmu-delphi.github.io/delphi-epidata/api/covidcast-signals/jhu-csse.html)
maintained by the [Delphi Research Group](https://delphi.cmu.edu/about/) at 
Carnegie Mellon University.  

For COVID-19 hospitalizations, until round 13, we used the 
[HealthData.gov COVID-19 Reported Patient Impact and Hospital Capacity by State Timeseries](https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh). 
We download the data weekly on Tuesday afternoon (or Wednesday afternoon 
if there are any difficulties) and store the CSV files in the folder
`visualization/data-goldstandard\hhs_hospitalization`. These data are
released weekly although, sometimes, are updated more frequently. We
aggregate the adult and pediatric daily admission data from the latest
version of the file we download. 
Starting Round 13, we will use the same truth data as the COVID-19 Forecast 
Hub, i.e., the hospitalization data from the HHS. We will use the 
distribution of the HHS data as provided by the 
[COVIDcast Epidata API](https://cmu-delphi.github.io/delphi-epidata/api/covidcast-signals/hhs.html) 
maintained by the [Delphi Research Group](https://delphi.cmu.edu/about/) 
at Carnegie Mellon University. 

The data are available in CSV format by target name in the `visualization/data-goldstandard` folder. 

#### - Visualization Data (`visualization/data-visualization`)

This folder contains all the data related to the scenario and the projections.
The file `sysdata.rda` contains multiple named vectors used as dictionary for 
translating multiple variable (location, model names, target, scenario, ...) 
from numeric or special ID to character and vice-versa.

##### - Scenario Information (`visualization/data-visualization/scenario-info/`)

A markdown file is generated for each round on the 
[Scenario Modeling Hub GitHub README](https://github.com/midas-network/covid19-scenario-modeling-hub/blob/master/README.md).
This file contains all the information for the rounds: scenario
details, common assumptions, etc. The markdown filtered selecting only the round
information and is used to generate the scenario information tab in the 
Scenario Modeling Hub Website. A CSV
file (`visualization/data-visualization/scenarion_round_info.csv`) is
also generated and updated for each round. It contains the scenario
names, ids, dates, etc. This CSV will be used internally on the website.

##### - Projections (`visualization/data-visualization/models/`)

The `models` folder contains 2 type of output organized by round and 1
CSV, all containing the projections information: </br></br> 
* The `model_description.csv` file contains the metadata information
for each projection. The file is updated each round and is generated
by extracting the information from the metadata file associated with
each model.
* The other outputs are organized by round
(`visualization/data-visualization/models/roundX`):

  * The `preprocessed_model_TARGET.csv` files contain, for each round,
a subset of all the projections (teams submissions + Ensemble)
containing the information for only 7 quantiles (0.01, 0.025, 0.25,
0.50, 0.75, 0.975, 0,99) and the point value for all locations and all
scenarios, and for a specific target. The files contains also
truncation information in a binary format (1: truncated, 0 or NA: not
truncated). For round 3, round 4, round 5, and round 6, the projected
values values beyond 80% of previously seen peaks were
truncated.
  * The cumulative projection over the projection period are
calculated for death, case, and hospitalization for each model and
location by using the scenario D as baseline. An Ensemble_LOP is then
recalculated with the cumulative projections. One CSV by
target is generated and is stored by round in the round folder. Each
file is named `zeroed_cum_TARGET.csv`. The cumulative projection over
the projection period are available starting round 7.

## Data license and reuse

We are grateful to the teams who have generated these scenarios. 
The groups have made their public data available under different terms and 
licenses. You will find the licenses (when provided) within the model-specific 
folders in the [data-processed](https://github.com/midas-network/covid19-scenario-modeling-hub/tree/master/data-processed) 
directory. Please consult these licenses before using these data to ensure that 
you follow the terms under which these data were released.

The COVID-19 Data Repository by the Center for Systems Science and Engineering 
(CSSE) at Johns Hopkins University are under the terms of the Creative Commons 
Attribution 4.0 International (CC BY 4.0) license.

For COVID-19 hospitalizations, the [HealthData.gov COVID-19 Reported Patient Impact and Hospital Capacity by State Timeseries](https://healthdata.gov/Hospital/COVID-19-Reported-Patient-Impact-and-Hospital-Capa/g62h-syeh) 
is originally published by the U.S. Department of Health & Human Services under 
[Public Domain U.S. Government](https://www.usa.gov/government-works). For more 
details, consult the official license text.

All source code that is specific to the overall project is available under an 
open-source [MIT license](https://opensource.org/licenses/MIT). We note that 
this license does NOT cover model code from the various teams or model scenario 
data (available under specified licenses as described above). 

## Funding

Scenario modeling groups are supported through grants to the
contributing investigators.

The Scenario Modeling Hub cite is supported by the 
[MIDAS Coordination Center](https://midasnetwork.us), NIGMS Grant U24GM132013 
to the University of Pittsburgh.
