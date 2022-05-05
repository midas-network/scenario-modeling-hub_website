</br><h2 style="color:#2d5973">Scenario Definition</h2></br>


|Scenario Fullname              |Scenario Id  |Scenario Name  |Social Distancing Measures                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |Testing-Trace-Isolate       |Masking                                                 |Vaccine Efficacy (2-Dose Vaccines)                                                                                                                                                                                                                                                                                                                               |Vaccine Availability                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |B.1.1.7 Variant Strain                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |Vaccine Coverage                                                                                              |
|:------------------------------|:------------|:--------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------|:-------------------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------|
|High Vaccination, Moderate NPI |A-2021-03-05 |highVac_modNPI |Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.   <span style=text-decoration:underline;>Declines gradually over a period of 5 months</span> starting at the beginning of March and ending in August at <span style=text-decoration:underline;>50% of the effectiveness of control</span> observed for February 2021.   Decline can be implemented at teams’ discretion (e.g., daily or monthly stepdowns), but should occur over the full period.   The effectiveness of control in February 2021 should be based on the last two weeks of the month.   Reduction should be implemented based on each team’s best judgment, but should be done in such a way that a 100% reduction (0% of Feb 2021 effectiveness) would approximate an epidemic without NPIs (e.g. no masks, no social distancing) in place, but still including immunity, vaccination, etc. We recognize that there is uncertainty about what the effects would be without NPIs; this uncertainty should be incorporated into the scenario projections.                                                 |constant at baseline levels |Included as part of “Social Distancing Measures” above. |<span style=text-decoration:underline;>First dose: _90% against disease_</span>, 14 days after 1<sup>st</sup> dose   <span style=text-decoration:underline;>Second dose: _95% against disease_</span>, 14 days after 2<sup>nd</sup> dose   Transmission impact at teams’ discretion and should be clearly documented in team’s metadata.   Doses 3.5 weeks apart |<span style=text-decoration:underline;>December, January, and February: based on data on administered doses</span> (second doses should be taken into account)   <span style=text-decoration:underline;>March-August: _35 million_ administered first doses/month</span>, with the intention of protocols being followed (70M doses/mo)   If the maximum level of vaccination specified (e.g., 90% for this scenario) is reached in all population groups, assume that no more vaccination occurs (i.e., do not model new doses beyond this amount)   The specified scenarios do not include the Johnson and Johnson one-dose vaccine, so it should not be modeled. Next round may include the explicit introduction of J&J vaccine. |Teams can model the B.1.1.7 variant as appropriate to their model. Any assumptions should be clearly defined in the metadata.The default assumptions are that the variant is 1.5x more transmissible than current strains and reaches 50% dominance by March 15 and 100% dominance by May 1 [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of cases infected by a single case over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R<sub>0</sub> in a classic epidemic model). No differences in severity, mortality, or VE are assumed in default. |<span style=text-decoration:underline;> No more than 90%</span>_ of any population group receives the vaccine |
|High Vaccination, Low NPI      |B-2021-03-05 |highVac_lowNPI |Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.   <span style=text-decoration:underline;>Declines gradually over a period of 5 months</span> starting at the beginning of March and ending in August at <span style=text-decoration:underline;>20% of the effectiveness of control (i.e., an 80% reduction in effectiveness)</span> observed for February 2021.   Decline can be implemented at teams’ discretion (e.g., daily or monthly stepdowns), but should occur over the full period.   The effectiveness of control in February 2021 should be based on the last two weeks of the month.   Reduction should be implemented based on each team’s best judgment, but should be done in such a way that a 100% reduction (0% of Feb 2021 effectiveness) would approximate an epidemic without NPIs (e.g. no masks, no social distancing) in place but would still including immunity, vaccination, etc. We recognize that there is uncertainty about what transmission would be without NPIs; this uncertainty should be incorporated into the scenario projections. |constant at baseline levels |Included as part of “Social Distancing Measures” above. |<span style=text-decoration:underline;>First dose: _90% against disease_</span>, 14 days after 1<sup>st</sup> dose   <span style=text-decoration:underline;>Second dose: _95% against disease_</span>, 14 days after 2<sup>nd</sup> dose   Transmission impact at teams’ discretion and should be clearly documented in team’s metadata.   Doses 3.5 weeks apart |<span style=text-decoration:underline;>December, January, and February: Administered doses</span> (second doses should take into account)   <span style=text-decoration:underline;>March-August: _35 million_ administered first doses/month</span>, with the intention of protocols being followed (70M doses/mo)   If the maximum level of vaccination specified (e.g., 90% in this scenario) is reached in all population groups, assume that no more vaccination occurs (i.e., do not model new doses beyond this amount)   The specified scenarios do not include the Johnson and Johnson one-dose vaccine, so it should not be modeled. Next round may include the explicit introduction of J&J vaccine.                       |Teams can model the B.1.1.7 variant as appropriate to their model. Any assumptions should be clearly defined in the metadata.The default assumptions are that the variant is 1.5x more transmissible than current strains and reaches 50% dominance by March 15 and 100% dominance by May 1 [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of cases infected by a single case over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R<sub>0</sub> in a classic epidemic model). No differences in severity, mortality, or VE are assumed in default. |<span style=text-decoration:underline;> No more than 90%</span>_ of any population group receives the vaccine |
|Low Vaccination, Moderate NPI  |C-2021-03-05 |lowVac_modNPI  |Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.   <span style=text-decoration:underline;>Declines gradually over a period of 5 months</span> starting at the beginning of March and ending in August at <span style=text-decoration:underline;>50% of the effectiveness of control</span> observed for February 2021.   Decline can be implemented at teams’ discretion (e.g., daily or monthly stepdowns), but should occur over the full period.   The effectiveness of control in February 2021 should be based on the last two weeks of the month.   Reduction should be implemented based on each team’s best judgment, but should be done in such a way that a 100% reduction (0% of Feb 2021 effectiveness) would approximate an epidemic without NPIs (e.g. no masks, no social distancing) in place but would still including immunity, vaccination, etc. We recognize that there is uncertainty about what transmission would be without NPIs; this uncertainty should be incorporated into the scenario projections.                                           |constant at baseline levels |Included as part of “Social Distancing Measures” above. |<span style=text-decoration:underline;>First dose: _50% against disease_</span>, 14 days after 1<sup>st</sup> dose   <span style=text-decoration:underline;>Second dose: _75% against disease_</span>, 14 days after 2<sup>nd</sup> dose   Transmission impact at teams’ discretion and should be clearly documented in team’s metadata.   Doses 3.5 weeks apart |<span style=text-decoration:underline;>December, January, and February: based on data on administered doses</span> (second doses should take into account)   <span style=text-decoration:underline;>March-August: _20 million_ administered first doses/month</span>, with the intention of protocols being followed (40M doses/mo)   If the maximum level of vaccination specified (e.g., 50% in this scenario) is reached in all population groups, assume that no more vaccination occurs (i.e., do not model new doses beyond this amount)   The specified scenarios do not include the Johnson and Johnson one-dose vaccine, so it should not be modeled. Next round may include the explicit introduction of J&J vaccine.      |Teams can model the B.1.1.7 variant as appropriate to their model. Any assumptions should be clearly defined in the metadata.The default assumptions are that the variant is 1.5x more transmissible than current strains and reaches 50% dominance by March 15 and 100% dominance by May 1 [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of cases infected by a single case over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R<sub>0</sub> in a classic epidemic model). No differences in severity, mortality, or VE are assumed in default. |<span style=text-decoration:underline;> No more than 50%</span>_ of any population group receives the vaccine |
|Low Vaccination & Low NPI      |D-2021-03-05 |lowVac_lowNPI  |Includes combined effectiveness/impact of all non-pharmaceutical interventions and behavior change.   <span style=text-decoration:underline;>Declines gradually over a period of 5 months</span> starting at the beginning of March and ending in August at <span style=text-decoration:underline;>20% of the effectiveness of control (i.e., an 80% reduction in effectiveness)</span> observed for February 2021.   Decline can be implemented at teams’ discretion (e.g., daily or monthly stepdowns), but should occur over the full period.   The effectiveness of control in February 2021 should be based on the last two weeks of the month.   Reduction should be implemented based on each team’s best judgment, but should be done in such a way that a 100% reduction (0% of Feb 2021 effectiveness) would approximate an epidemic without NPIs (e.g. no masks, no social distancing) in place but would still including immunity, vaccination, etc. We recognize that there is uncertainty about what transmission would be without NPIs; this uncertainty should be incorporated into the scenario projections. |constant at baseline levels |Included as part of “Social Distancing Measures” above. |<span style=text-decoration:underline;>First dose: _50% against disease_</span>, 14 days after 1<sup>st</sup> dose   <span style=text-decoration:underline;>Second dose: _75% against disease_</span>, 14 days after 2<sup>nd</sup> dose   Transmission impact at teams’ discretion and should be clearly documented in team’s metadata.   Doses 3.5 weeks apart |<span style=text-decoration:underline;>December, January, and February: based on data on administered doses</span> (second doses should take into account)   <span style=text-decoration:underline;>March-August: _20 million_ administered first doses/month</span>, with the intention of protocols being followed (40M doses/mo)   If the maximum level of vaccination specified (e.g., 50% in this scenario) is reached in all population groups, assume that no more vaccination occurs (i.e., do not model new doses beyond this amount)   The specified scenarios do not include the Johnson and Johnson one-dose vaccine, so it should not be modeled. Next round may include the explicit introduction of J&J vaccine.      |Teams can model the B.1.1.7 variant as appropriate to their model. Any assumptions should be clearly defined in the metadata.The default assumptions are that the variant is 1.5x more transmissible than current strains and reaches 50% dominance by March 15 and 100% dominance by May 1 [(see MMWR report)](https://www.cdc.gov/mmwr/volumes/70/wr/mm7003e2.htm); here a 1.5x increase in transmissibility is defined as the increase in the expected number of cases infected by a single case over their entire course of infection when there are no interventions or immunity in the population (e.g., a 1.5x increase in R<sub>0</sub> in a classic epidemic model). No differences in severity, mortality, or VE are assumed in default. |<span style=text-decoration:underline;> No more than 50%</span>_ of any population group receives the vaccine |


<hr style="border-top: 1px solid #FFFFFF;"/>
<hr style="border-top: 1px solid #211e6b;"/>
</br><h2 style="color:#211e6b">Common Assumptions</h2></br>
<b>- Submission date: </b>March 9, 2021</br> 

 <b>- Baseline date: </b>See specific details below</br> 

 <b>- End date for fitting data: </b>March 6, 2021 - no fitting should be done to data from after this date</br> 

 <b>- Start date for third-round scenarios: </b>March 7, 2021 (week ending March 12) - first date of simulated outcomes</br> 

 <b>- Simulation end date: </b>at least through week ending June 5, 2021 (13-week horizon); preferably Sept 4, 2021 (26-week horizon)</br> 

 <b>- Transmission assumptions: </b>models fit to US state-specific dynamic up until End date for fitting data specified above – no proscribed R<sub>0</sub>, interventions, etc.</br> 

 <b>- Pathogenicity assumptions: </b>no exogenous fluctuations in pathogenicity/transmissibility beyond seasonality effects</br> 

 <b>- Vaccine effectiveness: </b>level of effectiveness and available doses are specified for each scenario; assumptions regarding time required to develop immunity, age-related variation in effectiveness, duration of immunity, and additional effects of the vaccine on transmission are left to the discretion of each team</br> 

 <b>- Vaccine allocation: </b>between-state allocation is based on population per the CDC/NAS <a href=https://www.nap.edu/catalog/25917/framework-for-equitable-allocation-of-covid-19-vaccineresources target="_blank">guidelines</a>  (proportional allocation); within-state allocation and the impact of vaccine hesitancy are left to the discretion of each team</br> 

 <b>- Vaccine immunity delay: </b>There is approximately a 14 day delay according to the Pfizer data; because we suspect the post first dose and post second dose delays may be of similar length, we do not believe there is any need to explicitly model a delay, instead groups can delay vaccine receipt by 14 days to account for it</br> 

 <b>- Vaccine uptake: </b>See specific details below.</br> 

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

 <b>&emsp;- </b>Weekly incident reported cases</br> 

 <b>&emsp;- </b>Weekly cumulative reported cases since start of pandemic (use JHU CSSE for baseline)</br> 

 <b>&emsp;- </b>Weekly incident hospitalizations</br> 

 <b>&emsp;- </b>Weekly cumulative hospitalizations since simulation start</br> 

 <b>&emsp;- </b>Weeks will follow epi-weeks (Sun-Sat) dated by the last day of the week</br> 

 <b>- “Ground Truth”: </b>The same data sources as the forecast hub will be used to represent “true” cases, deaths and hospitalizations. Specifically, JHU CSSE data for cases and deaths and HHS data for hospitalization.</br> 

 <b>- Metadata: </b>We will require a brief meta-data form, TBD, from all teams.</br> 

 <b>- Uncertainty: </b>aligned with the Forecasting Hub we ask for 0.01, 0.025, 0.05, every 5% to 0.95, 0.975, and 0.99 quantiles</br> 

 <b>- Ensemble Inclusion: </b>at present time, in order to be included in the ensemble models need to provide a full set of quantiles</br> 
