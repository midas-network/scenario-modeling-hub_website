</br><h2 style="color:#2d5973">Scenario Definition</h2></br>


|Scenario Fullname                             |Scenario Id  |Scenario Name  |Social Distancing Measures                                                                                                                                                                                                                                                                                                |Testing-Trace-Isolate       |Masking                                                                                                                                                                          |Vaccine Efficacy                                                |Vaccine Availability                                                                                                                        |Vaccine Hesitancy                                          |Vaccine    |
|:---------------------------------------------|:------------|:--------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------------------|:----------|
|“Optimistic” Scenario                         |A-2020-12-22 |optimistic     |baseline state orders with regards to NPIs continue for six weeks from their start date (i.e., the date each individual state started the policy regime in place at baseline), interventions step down from baseline to the lowest levels seen since September 2020 in a particular jurisdiction over two one-month steps |constant at baseline levels |maintained at baseline levels indefinitely                                                                                                                                       |95% after two doses, 50% after one dose, doses 3.5 weeks apart  |Actually distributed doses in December (approx.), 25 million courses (50 million doses) in January, 25 million courses per month thereafter |NA                                                         |NA         |
|Business as Usual + Moderate Vaccine Scenario |B-2020-12-22 |moderate       |current elevated state orders with regards to NPIs continue for stated length or three weeks after the NPI is started if length is unstated; thereafter interventions step down from baseline to the lowest levels seen since May 2020 in a particular jurisdiction over two one-month steps                              |constant at baseline levels |maintained at baseline levels indefinitely                                                                                                                                       |70% after two doses, 20% after one dose, doses 3.5 weeks apart  |Actually distributed doses in December (approx.), 12.5 million courses in January, 25 million courses per month thereafter                  |NA                                                         |NA         |
|Fatigue and Hesitancy Scenario                |C-2020-12-22 |fatigue        |current elevated state orders with regards to NPIs continue for stated length or three weeks after the NPI is started if length is unstated; thereafter interventions step down from baseline to an additional 5% below the lowest levels seen since May 2020 in a particular jurisdiction over two one-month steps       |constant at baseline levels |adherence to these measures steps down from baseline to an additional 5% below the lowest levels seen since September 2020 in a particular jurisdiction over two one-month steps |95% after two doses, 50% after one dose, doses 3.5 weeks apart. |Actually distributed doses in December (approx.), 12.5 million courses in January, 25 million courses per month thereafter                  |no more than 50% of any priority group accepts the vaccine |NA         |
|Counterfactual Scenario                       |D-2020-12-22 |counterfactual |current elevated state orders with regards to NPIs continue for stated length or three weeks after the NPI is started if length is unstated; thereafter interventions step down from baseline to the lowest levels seen since May 2020 in a particular jurisdiction over two one-month steps                              |constant at baseline levels |maintained at baseline levels indefinitely                                                                                                                                       |NA                                                              |NA                                                                                                                                          |NA                                                         |no vaccine |


<hr style="border-top: 1px solid #FFFFFF;"/>
<hr style="border-top: 1px solid #211e6b;"/>
</br><h2 style="color:#211e6b">Common Assumptions</h2></br>
<b>- Submission date: </b>January 8, 2021 (approx.)</br> 

 <b>- Baseline date: </b>December 15, 2020 - date of baseline intervention levels</br> 

 <b>- Start date for first-round scenarios: </b>January 3, 2021 (week ending January 9) - first date of simulated outcomes; model should not be fit to data from after this date</br> 

 <b>- Simulation end date: </b>at least through week ending April 3, 2021 (13-week horizon); preferably July 3, 2021 (26-week horizon)</br> 

 <b>- Transmission assumptions: </b>models fit to US state-specific dynamic up until time of submission – no proscribed R<sub>0</sub>, interventions, etc.</br> 

 <b>- Pathogenicity assumptions: </b>no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects</br> 

 <b>- Vaccine effectiveness: </b>level of effectiveness and available doses are specified for each scenario; assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team</br> 

 <b>- Vaccine allocation: </b>between-state allocation is based on population per the CDC/NAS <a href=https://www.nap.edu/catalog/25917/framework-for-equitable-allocation-of-covid-19-vaccineresources target="_blank">guidelines</a>  (proportional allocation); within-state allocation and the impact of vaccine hesitancy are left to the discretion of each team</br> 

 <b>- Vaccine immunity delay: </b>There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it</br> 

 <b>- Vaccine uptake: </b>It is unlikely vaccine uptake will be 100% within prioritized groups, however sufficient data are not available to specify this; we will leave this to team discretion, but we ask that they include these assumptions in their meta-data file</br> 

 <b>- Vaccine rollout: </b>rollout to follow <a href=https://www.cdc.gov/vaccines/acip/meetings/downloads/slides-2020-12/slides-12-20/02-COVID-Dooling.pdf target="_blank">ACIP recommendations</a>  unless known to be contradicted by state recommendations</br> 

 <b>&emsp;- Phase 1a: </b>health care workers, long-term care facilities</br> 

 <b>&emsp;- Phase 1b: </b>frontline essential workers, adults 75+</br> 

 <b>&emsp;- Phase 1c: </b>other essential workers, adults with high-risk conditions, adults 65-74</br> 

 <b>- NPI assumptions: </b>phased reductions of NPIs in 2021 that align with patterns observed at different times in the course of the epidemic in 2020 (see scenario-specific guidance); teams have some liberty on how to implement these reductions within the guidelines</br> 

 <b>- Database tracking of NPIs: </b>teams may use their own data if desired, otherwise we recommend the following sources as a common starting point:</br> 

 <b>&emsp;- </b><a href=https://www.bsg.ox.ac.uk/research/research-projects/coronavirus-government-response-tracker target="_blank">Coronavirus Government Response Tracker | Blavatnik School of Government</a> </br> 

 <b>&emsp;- </b><a href=https://www.nga.org/coronavirus-state-actions-all/ target="_blank">Coronavirus State Actions - National Governors Association</a> </br> 

 <b>- Geographic scope: </b>state-level and national projections</br> 

 <b>- Results: </b>some subset of the following</br> 

 <b>&emsp;- </b>Weekly incident deaths</br> 

 <b>&emsp;- </b>Weekly cumulative deaths since start of pandemic (use JHU CSSE for baseline)</br> 

 <b>&emsp;- </b>Weekly incident cases</br> 

 <b>&emsp;- </b>Weekly cumulative cases since start of pandemic (use JHU CSSE for baseline)</br> 

 <b>&emsp;- </b>Weekly incident hospitalizations</br> 

 <b>&emsp;- </b>Weekly cumulative hospitalizations since simulation start</br> 

 <b>&emsp;- </b>Weeks will follow epi-weeks (Sun-Sat) dated by the last day of the week</br> 

 <b>- “Ground Truth”: </b>The same data sources as the forecast hub will be used to represent “true” cases, deaths and hospitalizations. Specifically, JHU CSSE data for cases and deaths and HHS data for hospitalization.</br> 

 <b>- Metadata: </b>We will require a brief meta-data form, TBD, from all teams.</br> 

 <b>- Uncertainty: </b>aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99 quantiles</br> 

